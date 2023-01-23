Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC2C54EB4
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 15:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjAWPkr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjAWPko (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 10:40:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2985FE9
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 07:40:42 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0twc6Y4Pz6J9tl;
        Mon, 23 Jan 2023 23:16:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 15:16:54 +0000
Date:   Mon, 23 Jan 2023 15:16:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] tools/testing/cxl: Use injected poison for get
 poison list
Message-ID: <20230123151653.00006eee@Huawei.com>
In-Reply-To: <e4c530ac9c073eb753a98a052216d58a571799e4.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
        <e4c530ac9c073eb753a98a052216d58a571799e4.1674101475.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 18 Jan 2023 21:00:20 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Prior to poison inject support, the mock of 'Get Poison List'
> returned a poison list containing a single mocked error record.
> 
> Now, following the addition of poison inject and clear support,
> use the mock_poison_list[] as the source of records for 'Get
> Poison List' requests.
> 
> This supports confirmation of inject and clear poison commands.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
A comment inline.  Either way I'm fine with this.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c | 56 ++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index bb0be9fe3fe9..14d74bfb3124 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -582,31 +582,51 @@ static struct mock_poison {
>  	u64 dpa;
>  } mock_poison_list[MOCK_INJECT_TEST_MAX];
>  
> +static struct cxl_mbox_poison_payload_out
> +*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
> +{
> +	struct cxl_mbox_poison_payload_out *po;
> +	int nr_records = 0;
> +	u64 dpa;
> +
> +	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> +	if (!po)
> +		return NULL;
> +
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds != cxlds)
> +			continue;
> +		if (mock_poison_list[i].dpa < offset ||
> +		    mock_poison_list[i].dpa > offset + length - 1)

I was thinking that we could move this to the add side of things, but
perhaps it actually makes sense in both code paths?

> +			continue;
> +
> +		dpa = mock_poison_list[i].dpa + CXL_POISON_SOURCE_INJECTED;
> +		po->record[nr_records].address = cpu_to_le64(dpa);
> +		po->record[nr_records].length = cpu_to_le32(1);
> +		nr_records++;
> +		if (nr_records == MOCK_INJECT_DEV_MAX)
> +			break;
> +	}
> +
> +	/* Always return count, even when zero */
> +	po->count = cpu_to_le16(nr_records);
> +
> +	return po;
> +}
> +

