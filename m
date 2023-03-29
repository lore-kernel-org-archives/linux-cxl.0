Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15356C74A5B
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 03:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjC3DZw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjC3DZv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 23:25:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632C525E
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 20:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRXeY27OMc75z8D4IQEC4L0WA3zcSgzjAYlL616JQA3GfxVVR8VhExv6YOYRpbQE4UEfzhMQToAYLbMiZVkWYWfeLhWQW+wjzujdgH0Uq94kptilzvJ/DwfpjVbUK0ODjk7zuxIE+ErnE0TV391IM/8yxmxCA8hVrh5tJF2yPPaQ3iTI1szAXOMopsIpP+FjWBBYt6B0/p2h/nSNa7y095r2prgsJQsOlsJIbh4AKbuVLjuWnGj4m3JCQTlCEK0Nh9n2hJ86BwEybPTuhAEosIdNsZs70iqG9nodRyoz/Vss87NhZXA5G/R3NZRxffPDBkeuW7P+ydGgtYcRo6OFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYw7XXFdlkgI7OPzzOXTCON8AUMGwqUl3sVjg4XqxpQ=;
 b=aaST1m2OHbpqUx/SX8riWKX4lTnZpDWqpebgEuPbAQfGI2pMbsZZHs1lMF1nHpBcHYI/mFi0jRSWUK564uvUnVvk/PWafHCLmQuKZcv24XF66LvpZX/yhoLGOZ3GabZ5osJQlKjYPACeoUH7m1YRniaVQ+zuaWZ063KPKRfwUch2MiPtPUACANtCXR5JnZycd1aXONqN0rQxOO2dkpA0vOgbA0WkQglaU/kU0OtQR56vclTf2eoouIRI8d9fsoGpHmlYgf094esNXsmJT1BHw9ETQoDrOoB6p0fJpgTK/lFoEGS8ZXbxh0dlX4elbcqACQ+DSfcMwZdMd6gzEvRn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYw7XXFdlkgI7OPzzOXTCON8AUMGwqUl3sVjg4XqxpQ=;
 b=lItGPXIq8aZMnsLiryuLYsBVF9l6ujD/M0iEFOwck5YvfdvosZM/pi9QEOAbsQcMq/pe0bWtG6JbgNSK+xQBR6Pjkiesq3RhWA8pLFZAsyW70TwBbvjhQtYaYKUOSZBm1iaVbHn9oYJjSexnkUICzAAYRycMD4PYFsZFtQrHQRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS7PR17MB6659.namprd17.prod.outlook.com (2603:10b6:8:e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 03:25:45 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 03:25:44 +0000
Date:   Wed, 29 Mar 2023 12:04:21 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZCRhhUDcmypVKu0X@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS7PR17MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b90cfe-e2dd-4db9-b0a2-08db30ce7248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x16fmKDG1jQGmbhNdhnGIFa1pYZYHig+mZoUpHz2DkDUc3a57qaP5WWuTKByMxZLzMCaqh6bTIppwjD77PFr/DD0c3tDv5xQkuIMbmDQx+SeqMQNVO4b618W94oFupbXGvzxyTzFMiZCl0NvsAh0DuAJqoKbhP+A0QmbiiALDCwxFi4O5rYqJ2q7pHkua30VFxk0f0C1auLSnJg27Asdq2M1BpfUTQ7blgKEVi+IMOAUbg0oSqAyFL+aKx5ifHR6jMje0e7ScWN9F8G7SUgk3gQ34906gIXDUVrd8lXsv/K0lHPRdhLo9nBxu/VjBNuMNF8AH9MRuVCCAIZN9UzzB/dEb7rk2xFA1GF2zVBAWYWnr7EeobJXCRIuojYOutV7utuB8NeLuMvr8JCtcZnSFeDtsM1V197BWXcuu/PLh5P6oKLbufMV1QAnbXTEWGHuSFp6xcV7IzuQNJIKNjaW855YYm5xciGBIFdlCUVrRscEx3F2K3ttKtNzm4Q2WbD4XDy/MsvbjZpLMcSMZOSXC/hGaGFOtkhX41daycmq8CJpZ0OfKsILmLHjA3OtwF7t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39840400004)(346002)(451199021)(316002)(478600001)(36756003)(86362001)(5660300002)(8936002)(66556008)(4326008)(44832011)(38100700002)(66476007)(8676002)(2906002)(6916009)(66946007)(6506007)(41300700001)(186003)(6666004)(26005)(6512007)(83380400001)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/bPohsm6lSUrnH4E1DEi1Dkz2Luix/xobek6+nuwzn6jXHgWYfYZrrgfkJL?=
 =?us-ascii?Q?yl1RDmsXAvf4xWH659I3//2QiWrJDgdOnbSgAcSWmpx4DYJrB4NoI1vlj/Aw?=
 =?us-ascii?Q?UOwmfYaV3YQl2OsI4NZFfIWu6LyZAfzgKCGVLGRk6JNdwZAN1UgNuvCtTZPF?=
 =?us-ascii?Q?U3RuM/SU9eq0nVG0vIOWV9ej7kvMxxJa87oHKxzzFtr2G47ZtNrAmWJd1hj1?=
 =?us-ascii?Q?uultfUUeaGW2NKSm0++7cNQqakR2EwqQsdsJ8znFx2sjILHzo9ZdrJJDuY3g?=
 =?us-ascii?Q?ggFN5bouOlud9hpd13QZZsDLBhu+s6Zm97m1eribRcAwIPaOWb9/NywJk8ol?=
 =?us-ascii?Q?Wq1pelEal9+y6g9k6TsXLfg4TlVOtq/sVEoEotUP1zx44/DbT4Dl9A4xyt3Y?=
 =?us-ascii?Q?fOc6HHyDLmaF3Nf+n4Fj1GxAVCoBo6arNRkRjjOmcTf5FXVYZAYcsImnGejB?=
 =?us-ascii?Q?x5RpWKcqEjBwSitqNfRcr5FcweL5dQ3x2cNDXp7IfzDltck/FWXJhuFakmXQ?=
 =?us-ascii?Q?2EY0Lz5hDQyps4tWFmz7yFKRgwRETpH7ryhqDRPSJAtkn4Q4+sGcL9CGPnWW?=
 =?us-ascii?Q?/k3xImi4GNICEtvXObDNeYjtQQOpTnclGuos6/58r0nTgyvsslsqGvQ4/w3a?=
 =?us-ascii?Q?dssIr6M/N/gmsCf8oW4ovxJEx2NmfeZnGr5XDfmm8tSaNUoPNzNg65F8m7y+?=
 =?us-ascii?Q?MVDMTYBrF2qXqFGuzMmZSZJ6NCCxTRjH/9/yfzuheBfSSbrZ32k1qkcDS24C?=
 =?us-ascii?Q?utTLzQyBOiCKSN4EgUJ/u+ILni3XOytn4JsbfnQYst4+T/ctyV5svZz4w3E4?=
 =?us-ascii?Q?OqIANxAhJ+ejQylW8MOInO2EcaAPLjek/DAyxjAqr72fTMBu1fbaXDeTcUoD?=
 =?us-ascii?Q?loWIyCDgOQ3Q3Ajk4giDBqQmRzmGAzbt4zkRJSM7PXquUmW69T8Xjr8qrp8U?=
 =?us-ascii?Q?TvrhmPn7R4kQX+KgKXFdHIfTEYQ3S6/ft56fYn4bPH8q36iVVShiUkKpsFoY?=
 =?us-ascii?Q?RjoDVDz3wqTvvcWRuwE6W6grtdcATuPsTHjDSoyIN2anDSdBO4Ifg23Hbmcx?=
 =?us-ascii?Q?gc7Z0ATPGCwS8SXwZM8b0sBuuo9k4R0IE3uT1GPRvmjKprksjJt4MpeWJ4s6?=
 =?us-ascii?Q?IaIY0HeH1yKspi5pBMHQpvekulu9Pl4J61EoqyLXC+yAIb/CQOJkH1HXVvwT?=
 =?us-ascii?Q?cG3gWb0lvm3CuK6hrRHc1DeLBTlMdHxEpuyiFvS7v2mC5ufL+HS6aQR3y89E?=
 =?us-ascii?Q?RzSKlFU3/q6yedGyBz/ZvL1kMfrja/L5zz0dp4RU+b+PnUAg6E9GNCgZyAXg?=
 =?us-ascii?Q?b5b2d4D1Vw/rwyP0QJnTULH700vLeeSHlH4s/AleY57t41jQ++49W5oqNQSj?=
 =?us-ascii?Q?aLst1QpA+YWjhc4Xo89GbPFrFp32IDX9FXgJmol+YHO3nIRQgOb6RnNM2LZf?=
 =?us-ascii?Q?SSLl0ZEU4I9s0FooaG4cNo+pnMUwIZvTX8LhyWZiQhVPEcgvJU4ramknOB5D?=
 =?us-ascii?Q?qYm2ecHjGt9nFxA82OPjM8iisJXcwjYNRsdJXk2YYrR7/A1aXAitU/YbJFnI?=
 =?us-ascii?Q?9hPEZa14mSfuoacqPStXUUTxzp427QhLSUO3Pf9VbElUYwBqi0oKYM9DQ+qk?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b90cfe-e2dd-4db9-b0a2-08db30ce7248
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 03:25:44.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNy82wf81uQjr5LCJ1R+xpAHYRNKklI0qUj8bHeJ6vUDju97Fn/UbT/HihbsnEl2AAVImefeK2JtxB5hY+HfssI1/Nr+Nj8/tiH2UFbjZGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR17MB6659
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 02:35:55PM -0700, Dan Williams wrote:
> One motivation for mapping range registers to decoder objects is
> to use those settings for region autodiscovery.
> 
> The need to map a region for devices programmed to use range registers
> is especially urgent now that the kernel no longer routes "Soft
> Reserved" ranges in the memory map to device-dax by default. The CXL
> memory range loses all access mechanisms.
> 
> Complete the implementation by filling out ways and granularity, marking
> the DPA reservation, and setting the endpoint-decoder state to signal
> autodiscovery.
> 
> Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9884b6d4d930..5339c0719177 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -738,20 +738,26 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> -static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> -					    struct cxl_decoder *cxld, int which,
> -					    struct cxl_endpoint_dvsec_info *info)
> +static int cxl_setup_hdm_decoder_from_dvsec(
> +	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
> +	int which, struct cxl_endpoint_dvsec_info *info)
>  {
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range *range;
> +	int rc;
> +
>  	if (!is_cxl_endpoint(port))
>  		return -EOPNOTSUPP;
>  
> -	if (!range_len(&info->dvsec_range[which]))
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	range = &info->dvsec_range[which];
> +	if (!range_len(range))
>  		return -ENOENT;
>  
>  	cxld->target_type = CXL_DECODER_EXPANDER;
>  	cxld->commit = NULL;
>  	cxld->reset = NULL;
> -	cxld->hpa_range = info->dvsec_range[which];
> +	cxld->hpa_range = *range;
>  
>  	/*
>  	 * Set the emulated decoder as locked pending additional support to
> @@ -760,6 +766,17 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>  	port->commit_end = cxld->id;
>  
> +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, range_len(range), 0);

I have an example host where *dpa_base ends up being 0x0 here, and as a
result later down the line the region fails to register with this:

[   21.974117] cxl_pci 0000:3f:00.0: mem0:decoder1.0 no CXL window for range 0x0:0x1fffffffff

this traces back to here:

int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
                                struct cxl_endpoint_dvsec_info *info)
{
        u64 dpa_base = 0;    <- dpa_base is set to 0 and never updated
...
        for (i = 0; i < cxlhdm->decoder_count; i++) {
...
                rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
                                      &dpa_base, info);
}


static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
                            int *target_map, void __iomem *hdm, int which,
                            u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
{
... passed directly into here
        if (should_emulate_decoders(info))
                return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
                                                        which, info);
...
}

static int cxl_setup_hdm_decoder_from_dvsec(
        struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
        int which, struct cxl_endpoint_dvsec_info *info)
{
        rc = devm_cxl_dpa_reserve(cxled, *dpa_base, range_len(range), 0);
        if (rc) {
                dev_err(&port->dev,
                        "decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
                        port->id, cxld->id, *dpa_base,
                        *dpa_base + range_len(range) - 1, rc);
                return rc;
        }
        *dpa_base += range_len(range);
        cxled->state = CXL_DECODER_STATE_AUTO;

        return 0;
}


(full cxl log with bonus prints i added)
[   21.607034] cxl_pci 0000:3f:00.0: No component registers (-19)
[   21.641831] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
[   21.642866] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
[   21.643686] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
[   21.644371] cxl add_dpa_res: (0, 1fffffffff)
[   21.645540] cxl add_dpa_res: (2000000000, 1fffffffff)
[   21.965692] cxl hdm dvsec range: (0, 1fffffffff)
[   21.967045] cxl emulating decoders: dpa_base(0)   <-  *dpa_base
[   21.967778] cxl_add_to_region: searching for root decoder with address range(0, 1fffffffff)
[   21.972824] cxl match decoder: found root decoder, r1(1050000000, 304fffffff) r2(0, 1fffffffff)
[   21.974117] cxl_pci 0000:3f:00.0: mem0:decoder1.0 no CXL window for range 0x0:0x1fffffffff
[   21.974905] cxl discover_region: failed to add to region: 0x0-0x1fffffffff



Ultimately having trouble deciding if this is something broken with
bios, the setup_hdm_decoder code, or the discover_region code.  I'm not
PCI guru, but we should expect the rdm dvsec range to be in the range of
the root decoder window / CFMW:  r1(1050000000, 304fffffff)


confirming this is the issue, i *forced* the dvsec range register to read
out base+0x1050000000


diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7328a2552411..6fc6df0f7b5a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -340,12 +344,16 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
                if (rc)
                        return rc;

                base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;

                info->dvsec_range[i] = (struct range) {
-                       .start = base,
-                       .end = base + size - 1
+                       .start = 0x1050000000 + base,
+                       .end = 0x1050000000 + base + size - 1
                };


And this resulted in everything working "as one would expect"

[user@host0 ~]# ls /sys/bus/cxl/devices/
dax_region0  decoder0.0  decoder1.0  endpoint1  mem0  region0  root0

[user@host0 ~]# numactl --hardware
available: 2 nodes (0-1)
node 1 cpus:
node 1 size: 0 MB
node 1 free: 0 MB
node distances:
node   0   1
  0:  10  50
  1:  255  10

[user@host0 ~]# echo online_movable > /sys/bus/node/devices/node1/memory33/state
[user@host0 ~]# numactl --hardware
available: 2 nodes (0-1)
node 1 size: 2048 MB
node 1 free: 2048 MB
node distances:
node   0   1
  0:  10  50
  1:  255  10


Basically the question is:

Is the DVSEC Range Register expected to be programmed by bios, and are
not being programmed correctly?

Or is there something else missing here to correct for the CMFW base?



If it's the former, then this patch set is gtg and i'm happy to add my
Tested-by tag.  If it's the latter, can we hotfix it before release?



> +	if (rc) {
> +		dev_err(&port->dev,
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			port->id, cxld->id, *dpa_base,
> +			*dpa_base + range_len(range) - 1, rc);
> +		return rc;
> +	}
> +	*dpa_base += range_len(range);
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +
>  	return 0;
>  }
>  
> @@ -779,7 +796,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	} target_list;
>  
>  	if (should_emulate_decoders(info))
> -		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> +							which, info);
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> 
