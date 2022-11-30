Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC359C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 14:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiK3O6x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 09:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK3O6w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 09:58:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD717054
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 06:58:50 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMj1r5scRz6HJXP;
        Wed, 30 Nov 2022 22:55:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 15:58:48 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 14:58:47 +0000
Date:   Wed, 30 Nov 2022 14:58:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] tools/testing/cxl: Mock the Inject Poison mailbox
 command
Message-ID: <20221130145847.00007ae4@Huawei.com>
In-Reply-To: <08eddfad079afbab1f80f17d9670b40b2a7bdea8.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
        <08eddfad079afbab1f80f17d9670b40b2a7bdea8.1669781852.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 29 Nov 2022 20:34:35 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Mock the injection of poison by storing the device:address entry in a
> cxl_test array: mock_poison[]. Limit the array to 64 entries and fail
> new inject requests when full.
> 
> Introducing the mock_poison[] list here, makes it available for use in
> the mock of Clear Poison, and the mock of Get Poison List.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Main question I have here is whether we want to mock per device injected poison
lists, or just one global.  I think we want per device so we can reflect
the limits as would be retrieved from Identify Memory Device Output Payload.
Whilst we don't do anything useful with it yet, we should also update
the mocked response to that command to reflect this.

Perhaps we should have a sysfs attribute to read how many entries we can
inject?  Seems like that would be useful for testing flows on real devices,
particularly if the device only supports a very small number!

> ---
>  tools/testing/cxl/test/mem.c | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index a4f81915ec03..98acb9a644df 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -13,6 +13,7 @@
>  #define LSA_SIZE SZ_128K
>  #define DEV_SIZE SZ_2G
>  #define EFFECT(x) (1U << x)
> +#define MOCK_INJECT_POISON_MAX 64
>  
>  static struct cxl_cel_entry mock_cel[] = {
>  	{
> @@ -43,6 +44,10 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
>  		.effect = cpu_to_le16(0),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>  };
>  
>  /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -210,6 +215,51 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +static struct mock_poison {
> +	struct cxl_dev_state *cxlds;
> +	u64 dpa;
> +} mock_poison[MOCK_INJECT_POISON_MAX];

Don't we want one of these per device instance?

> +
> +static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
> +		if (!mock_poison[i].cxlds) {
> +			mock_poison[i].cxlds = cxlds;
> +			mock_poison[i].dpa = dpa;
> +			return true;
> +		}
> +	}
> +	dev_dbg(cxlds->dev, "Mock poison list full: %d\n",
> +		MOCK_INJECT_POISON_MAX);
Slightly nicer maybe to use the text from
https://elixir.bootlin.com/linux/latest/source/drivers/cxl/cxlmem.h#L128
and have: "Mock poison injection limit has been reached: %d\n" ..

> +	return false;
> +}

