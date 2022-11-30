Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C30FC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 15:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiK3PP3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3PP2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 10:15:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133AF43852
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 07:15:27 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMjP01lGJz6HJZg;
        Wed, 30 Nov 2022 23:12:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 30 Nov 2022 16:15:23 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 15:15:23 +0000
Date:   Wed, 30 Nov 2022 15:15:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/5] tools/testing/cxl: Use injected poison for Get
 Poison List
Message-ID: <20221130151522.00007c28@Huawei.com>
In-Reply-To: <2c068669b1b31a94b319f60c413c2169bb854111.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
        <2c068669b1b31a94b319f60c413c2169bb854111.1669781852.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 29 Nov 2022 20:34:37 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Prior to poison inject & clear support, the mock of 'Get Poison List'
> returned a list containing a single mocked error record.
> 
> Now that the mock of Inject and Clear poison maintains a mock_poison[]
> list, use that when available for the device. Otherwise, return the
> existing default mocked error record.
> 
> This enables roundtrip userspace testing of the inject, clear, and
> poison list support.

I'm not that keen on having an unclearable record, unless you handle that
with the right error flow for clear poison.
Plus I think you should always return that as well as the injected poison list
so this is consistent.

Whether it matters to model it that well in the mocking code?  Up to you...

Jonathan



> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 97 +++++++++++++++++++++++++-----------
>  1 file changed, 69 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9d794fbe5ee1..31c147cf2d5b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -224,6 +224,75 @@ static struct mock_poison {
>  	u64 dpa;
>  } mock_poison[MOCK_INJECT_POISON_MAX];
>  
> +struct mock_poison_po {
> +	struct cxl_mbox_poison_payload_out poison_out;
> +	struct cxl_poison_record record[MOCK_INJECT_POISON_MAX];

Maybe use a variable length final element [] so that you can then
create a 1 record version on demand where it is used for
the default record.

> +};
> +
> +/*
> + * Use the default poison payload when no injected poison is currently
> + * mocked for this device. Mock one poison record with length 64 bytes.
> + */
> +static struct mock_poison_po default_poison_po = {
> +	.poison_out.count = cpu_to_le16(1),
> +	.record[0].length = cpu_to_le32(1),
> +};
> +
> +static struct mock_poison_po *cxl_get_injected_po(struct cxl_dev_state *cxlds,
> +						  u64 offset, u64 length)
> +{
> +	struct mock_poison_po *po;
> +	int nr_records = 0;
> +	u64 dpa;
> +
> +	po = kzalloc(sizeof(*po), GFP_KERNEL);
> +	if (!po)
> +		return NULL;
> +
> +	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
> +		if (mock_poison[i].cxlds != cxlds)
> +			continue;
> +		if (mock_poison[i].dpa < offset ||
> +		    mock_poison[i].dpa > offset + length - 1)
> +			continue;
> +		dpa = cpu_to_le64(mock_poison[i].dpa |
> +				  CXL_POISON_SOURCE_INJECTED);
> +		po->record[nr_records].address = dpa;
> +		po->record[nr_records].length = cpu_to_le32(1);
> +		nr_records++;
> +	}
> +	if (!nr_records) {
> +		kfree(po);
> +		return NULL;
> +	}
> +	po->poison_out.count = cpu_to_le16(nr_records);
> +	return po;
> +}
> +
> +static int mock_get_poison(struct cxl_dev_state *cxlds,
> +			   struct cxl_mbox_cmd *cmd)
> +{

Why the function move?  If you want to do this, a trivial move only
patch first would have bad it slightly easier to review. But given it's small
not worth doing now, particularly as most of the function changes anyway.


> +	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
> +	struct mock_poison_po *po;
> +
> +	po = cxl_get_injected_po(cxlds, pi->offset, pi->length);
> +	if (!po) {
> +		po = &default_poison_po;

Keep the comment from below on what this value is. It is weird enough
to be worth a comment.

I'd be tempted to make the default_poison_po const and use a copy
of it here to avoid fun races on reads from multiple devices.
Or just allocate a 1 element version and fill it here.  However,
I think we should really have both the default and injected elements.

> +		po->record[0].address = cpu_to_le64(pi->offset |
> +						    CXL_POISON_SOURCE_INTERNAL);
> +	}
> +	if (cmd->size_out < sizeof(po))
> +		return -EINVAL;

This isn't technically correct, though it's probably fine for how we currently
use it. Should really assume full mailbox size and fill on that basis (record
count etc) but only copy the size of the target buffer.
Not sure we care enough about this being 'right' as opposed to useful.

> +
> +	memcpy(cmd->payload_out, po, sizeof(*po));
> +	cmd->size_out = sizeof(po);
> +
> +	if (po != &default_poison_po)
> +		kfree(po);
> +
> +	return 0;
> +}
> +
>  static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
>  {
>  	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
> @@ -293,34 +362,6 @@ static int mock_inject_poison(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> -static int mock_get_poison(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> -{
> -	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
> -
> -	struct {
> -		struct cxl_mbox_poison_payload_out poison_out;
> -		struct cxl_poison_record record;
> -	} mock_poison_list = {
> -		.poison_out = {
> -			.count = cpu_to_le16(1),
> -		},
> -		/* Mock one poison record at pi.offset for 64 bytes */
> -		.record = {
> -			/* .address encodes DPA and poison source bits */
> -			.address = cpu_to_le64(pi->offset |
> -					       CXL_POISON_SOURCE_INTERNAL),
> -			.length = cpu_to_le32(1),
> -		},
> -	};
> -
> -	if (cmd->size_out < sizeof(mock_poison_list))
> -		return -EINVAL;
> -
> -	memcpy(cmd->payload_out, &mock_poison_list, sizeof(mock_poison_list));
> -	cmd->size_out = sizeof(mock_poison_list);
> -	return 0;
> -}
> -
>  static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct device *dev = cxlds->dev;

