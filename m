Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17D3033CB;
	Tue, 28 Jul 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207829; cv=fail; b=QJEdp/XwkSnC1GKDMHgU21uu5HNkCfUkfjGRwF/CjEjkXGkRmDpHvbf64JR105yTEZRLPUbdY/2YfkhiH7xE8lBq0HNHL9X7cZBS3jUosiD0cWHARkl+KL4L29XFBQp6YEnf1pN4ex4B4ra/OoQhATaQ4dwAlASCQF9zupWGz68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207829; c=relaxed/simple;
	bh=Jt4A9dNUsHFGbKoDo3cjq5RrlK3l7aP2PJMAMTZJOjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdDVMevfzGcDhHRPTvq2JVhy7TleGeJkGyRP4F5065iBAa8Sw403c+eOuWgQ/9p+Sdhu+QFA+tjbFjkpyDGSKYigexoulHBWsVbrpdrtAuvO7zoSwfRx69PRQY9+JFbHMqaqYiUnNVaRAZEdJGdGxC70/YRlq35niGoJiuwLZAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VX/CAkf6; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VX/CAkf6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnzMJGzid4owuK1/OsAKTJzJisHmj9Z3WV25HqAZfCzl0m6t1J9qD+VuB9+iZJ4stdv3VQ7r1lSdepbpkX1UBezyQbsa5CiR9nl3uqVgXdGY1G0ttcgvMNHWZfWTNUfGv6hs5spgmqCp6p3xRQ0CEMJYIzfM2sY+bsIa3QVuMAg6a6X+Ip18IVQbI6imt667099G8wchO+uHZ92VLkoboeXlhxoOuT1egYQMyeGTBpTGmVMT0HpAA0PLChaC02K1Vh4QaS7IouZKZsZwEz3ncxUIsghQHZ7FIpi7FdywaLyjaJ4GyzBV1gbA92m1LLFpDIrIoIdP/5SsZqTkb5yFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XC5fd21NkguNa03J5mhVpD6nbm5Uy28FDzAlIn6b8w=;
 b=sSimKLPdaEKaSUJT4K0apjCADiHx/4hwzpYhmlXrjFePnqvQ7jzrl35IsmHFXmbaakOg3mnnd2YDMnzcBSJN508/FzTEd/2TgsYjjuSVqMTg0cjwnPO57t33/li+4+WxG2YuAOGtqJrLUhpU44n+p+Kt3xOnQwYvbP8fMn+YS1NgvcvMKsx0xKXpvWGUxrS8Yz49llq3nhuzME9tvRy0mN1Yu9U3keWVX7Ici2wVmOewlyN7r+dF+t1mWZIV+AsgdYLoAq1GVw0uYUlkzjyduuWmGW7zW+2ZLTwK9x/rN7i/qKMf2dc4VaToUkvaSUPIV2zdaGmChQZ+J09xaP5qqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XC5fd21NkguNa03J5mhVpD6nbm5Uy28FDzAlIn6b8w=;
 b=VX/CAkf6Z+ItxnxmWkssm4O76HH6T/uRlMQIfn4nO+dRjQF0ae5zrZ72m0tKzvBDKg+o4UbsB4c5OrHPiA2sQ1hkN2pN9bnSLxah9+oetM9uW08h/FO02zjL4IDliUv7rkGPJ6dW9xgVKM4/8OBSkuCCiqtJuyGnyhWjtbBQUtI8cJw4A+w4tQAZS3JyDm0g6OxmIEJwGnV+6Uof2o4edyzI+TwlqgtDrfqhv8p0CBYApNcNZu42urcjT6Si2MlTmbZKiQzlyl4VawBBmyH6tkUiRp6QwJ2yT+PWgCRCPfd83YWZxgf48kViCQuRQ0UhWNBtmXJYxaTVd9dIop+Z0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 03:03:45 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 03:03:44 +0000
Date: Tue, 28 Jul 2026 11:03:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sreddym@nvidia.com, smadhavan@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
Message-ID: <amgQUnkQ1VjyXtzx@MWDK4CY14F>
References: <20260727103743.63343-1-icheng@nvidia.com>
 <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9c859c-b90d-4276-b3e9-08deec54d58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	qbhreDTZxuoY/R82fCP8g2ZO96jzMU8lF+JvLJthHzVsaUAVCzZt7868qVSbi+ev0AUiXTq13qtIgkTR5UU6RLlFbWQV/MPf57yZun9uVUZ0dmWsHam+SJJyjm3ViBretNaiAL6Vb5uVKlwvoakAFT3SB1mSCx9S1QbtADidCP89/2sPol7ar0TDQZkfqg0gKz2Npqj6ktSIQt89YFYzzEQOtKidTb9WtIZTSCRscXYQWoJ/RC22BHfXOdmc5xuAs4w9QpWwUbdGlvEkl07JJqdbCF32bi8BsxUy7Cj9X5kDf37Vtc7BO8uJkmtoAs/tYHoy+OAXcxB4iyx0jV1zRvUF4ikKB0aNavpOJjMyBe6sUk3f8Pujz8ohPyEFKT5xDPP9YHgpxQ0Xm86d8f0MKyZAA/BdV343q1IMqeawCshabtoY/g0QCxHLn0cNKW44jAxpCYoAm9KldYO1HZX4rB9f2eRD5+EhUxO1qVvndZXBPzMviBNfsvODi8YP05ObezGY7nnxppaGSkM7yGHqZ4vKF4ew8OqPinKzApiwPek7B1ptsAqZrR/1NGQqF8upGfj9aZG7l8LxZiW4XBXLbZDe4/ywxNyst73QNvEov2W6AdyMT2kQElnsj3atZgmcn4AQlpFg7ZhnPFU+NMq14s2NFMOUuu6aDcxtuzwGVJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDxnkOMKenKPnPMj3I0aXH+C4yUpOyei2xVa7n9rvNAdYvnft1dVmUijisrE?=
 =?us-ascii?Q?C1UhcLjp9DxzaaljU1znCLKOY33TaodHukkOA/BMh3nZw5GGFO/qov/iwlsO?=
 =?us-ascii?Q?NJggAsanaj0J6q2L382PaZYuwV+AtRFQxjVRbLoHDJW0obueCSm1IfjV7scc?=
 =?us-ascii?Q?X9g/CTdG9v/cYy3qZpkwvNZF3KESh/4dzVatvA6VOW3O6TsWjGNxYFKM2CBj?=
 =?us-ascii?Q?UsL4M3AJ/LKkQmi/dd4GnOSZ3LnL/76/FrOGMLv2uGj4N0WPk6ho8H4w1cCO?=
 =?us-ascii?Q?t17WU5e9FFFEDIE0CCrgR9uswv/4wQyxQzLpTsp0GFfOphwHpvqOUEpE33rt?=
 =?us-ascii?Q?rv01mci5CEJxpaSLjEYwSOZBlWdpYKgdwYJ8vFL9S8spr/6u1xR0arVisxIc?=
 =?us-ascii?Q?eg/CZJyuT9wUEKEwd7UkdoLSq3R20HEWvx+x8yGS1QnrVdFCnI2Be3EuPFdT?=
 =?us-ascii?Q?NN45hzHdfOSnicjwIxJh5Yoo4bpdcCHIDFLfBlg6TncB15VyACi1/ouvqx04?=
 =?us-ascii?Q?VynNjlOjXWa1NuqQfRs0wdjlyY711pUPVGLwMFyY6dvBuFushQhxKNCB5hEP?=
 =?us-ascii?Q?rsiAp49M0/T8bfZjG/dzjyEeLfF73xh1q0ibTjtUW/57P6vNfRP88/CNuAvn?=
 =?us-ascii?Q?Kwvv8fbchqylf5dUF9MBsjxNz38JHnaIq/Z5GYnS1iG6Wf6r9GobxTjFSBIY?=
 =?us-ascii?Q?978kFi2pFO/EdYwZFTprR1RZsxTTnnixtpeltQmx4tGFbB0mxiiUldJQPrN6?=
 =?us-ascii?Q?L02ILXy6mEmaXpO8kciDOXLUXCibewgNQgDZpLPPijtJwruAOP6ZHgvw+a+7?=
 =?us-ascii?Q?iHhNU4FhQvW5U1Kv0IE6ohjkklGrfyITWpOKVFd6f0M1rNfya/NWdJhUyNnI?=
 =?us-ascii?Q?8yqT7o9WEk7ZkJuY76WAJjFbDF67dJLDneOVqedcBVMzk/3pqeUUGAvtQX3I?=
 =?us-ascii?Q?x/Ws2SjY6CirVDKIINn8ZPOWFuRvB4go1CEqFVhePrVHD8NgqxYEjRhCa/Op?=
 =?us-ascii?Q?9g67ZwN1CzUSBF46oV8zUBxPP0BhBU9rIZ0w5JIv5BQp21cL2j62xumkW/51?=
 =?us-ascii?Q?8SdKGjHoo1Oxy65qf8Ufu4ArKwE6OBe04xpE+SdKTDtK9/tUcTKhgVmtGcog?=
 =?us-ascii?Q?4eaSS9bBFcfJdCw+wUpTDqNGHT3hapfO6Ci3GSEUwPo9JIGpllS/ErrpJsQ2?=
 =?us-ascii?Q?zd9aHhgi6MHzT1hdbXmTuoz9QKfjTl3Y3Gkpxg+j1XnWQkqR87HYuwpKlGpj?=
 =?us-ascii?Q?qGw/Bk1xZ/GFWXmA/7iJD2Y2viFiMBmVORyZG2Fh7Ij/D6ILmTpsHlp4c3VJ?=
 =?us-ascii?Q?H+e98cTqRjzS/7guwN7QdbzdBv6e8oTJqzY+4PYdBLaBhvGkYkEwXkWLeUPt?=
 =?us-ascii?Q?LPQc8ubyQu4/Hkduavi4x2DolpWJRYefrjiTa7flRWfiLNdwH6H/AFPDXefI?=
 =?us-ascii?Q?QWxjrXNjK3E4OzM59nLXM1vSbuypASQpb23rvlMZLG89X6yrUKLb98yImsob?=
 =?us-ascii?Q?2IvAzWQd1BiQV16MIh5t65szZwQbmjYA1T8dDgJ5TLGsAU4yhkpfrmqnVxO2?=
 =?us-ascii?Q?iBPyyT3o553JI9+Ke05VDkqJxpH3PRoPbUEvjgE8i5sND8TifDfwjABT8mvc?=
 =?us-ascii?Q?R75F7zcNq2pUw95PUMEJijq8+cg8uFrDs1sQ3d4wPY7wGwV4Cd9tXW6Xuxxw?=
 =?us-ascii?Q?Inz6pLG8YwpSqaO3VHbbLHrzxogdcUjKlalRKOf60A2nCuW7Wqna4AMpi7fA?=
 =?us-ascii?Q?0IJBPzDMOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c859c-b90d-4276-b3e9-08deec54d58b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 03:03:44.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4+WQaZ9Z9BXYnb/VJWqUgmfZ7uYjMsIXfqWqlfK0NIO848H2+ICDNMxl3RiqoUa8r+bf27aMe0GlYE0UlvHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076

On Mon, Jul 27, 2026 at 01:25:48PM +0800, Dave Jiang wrote:
> 
> 
> On 7/27/26 3:37 AM, Richard Cheng wrote:
> > After a CXL endpoint is PCI hot-removed and the bus rescanned, an
> > auto-discovered region fails to rebiuld and is lost, evne though the
> 
> rebuild
> even
>

Hi Dave,
Thanks for the review, I'll fix the typo in v2.
 
> > device's HDM decoder is still committed and decoding.
> 

I think this part is talking about physical remove/insert ? sorry maybe I commit message was too vague about the scenario.
The case here is a SW-only teardown via sysfs, this is what I did.

"""
$ echo 1 > /sys/bus/pci/devices/$BDF/remove
$ echo 1 > /sys/bus/pci/devices/$BDF/rescan
"""

No physical removal, no power cycle, no link-down, no reset. Linux drops and re-enumerates the same device, which never stopped running.
The endpoint HDM decoder is still committed.

The device is byte-identical before and after, the kernel doesn't clear it either, the decoder is locked and cxl_decoder_reset() returns
early for CXL_DECODER_F_LOCK before touching any register. The memory keeps decoding.

I don't think anything needs re-programming here? the only thing lost is kernel-side bookkeeping on the passthrough decoder, which is
freed with port and reallocated with F_ENABLE clear on rescan. The endpoint recovers its state from HW.
The passthrough decoder has no HW to recover from, that asymmetry is the bug.

> Also, a complete different device with possibly different size can be inserted. And the device showed up would be unconfigured. Given
> there's no BIOS to program the device since the OS has taken over, should it be still considered part of the auto-region?

Agreed that would be wrong, and I don't think this patch allows it. A different or freshly-inserted device fails the existing endpoint
checks, its own decoder won't come back COMMITTED with a matching HPA range, so cxl_add_to_region() won't re-assemble the auto-region
relardless of what the passthrough decoder's flag says. This patch guards on the decode config still matching (iw, ig, spa_maps_hap()),
and on !cxld->commit, so it can only ever touch a SW-only stub.

So the coverage here is SW-only, I should state it more clearly in v2.

Btw, the check "!cxld->commit" is doing a lot of implicit work in the code base, I think that's worth fixing regardless of the patch.
"commit == NULL" is not unique to passthrough decoders, cxl_setup_hdm_decoder_from_dvsec() also sets "commit = NULL" for DVSEC-emulated
RCD endpoint decoders, and root decoder never set it. My call happens to be safe, but that isn't visible from the condition.

I would suggest an inline helper like the following, do you think it's reasonable ?

"""
static inline bool cxl_decoder_is_passthrough(struct cxl_decoder *cxld)
{
    if (cxld->commit)
        return false;
    if (!is_switch_decoder(&cxld->dev) || is_root_decoder(&cxld->dev))
        return false;
    return to_cxl_switch_decoder(&cxld->dev)->nr_targets <= 1;
}
"""

There're about 4 call site today, and it distinguishes "passthrough" from "has no commit routine" , which are currently the same check
for different things.

Happy to send it as a separate patch and make this one a patch series if you prefer the shape.

Best regards,
Richard Cheng.

> Any thoughts Jonathan?
> 
> > 
> > A single-dport host bridge/root port has no HDM decoder capability, so
> > its switch decoder is a SW-only passthrough. Its CXL_DECODER_F_ENABLE
> > flag is cleared on region teardown and never restored on rescan, so
> > cxl_port_setup_targets() fails with -ENXIO.
> > 
> > Re-enable the passthrough decoder when its interleave and HPA config
> > still match the region, it holds no HW state.
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/core/region.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..011ceb5bae79 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1574,6 +1574,19 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	}
> >  
> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > +		/*
> > +		 * A passthrough switch decoder holds no HW decode state.
> > +		 * It's CXL_DECODER_F_ENABLE flag is pure software bookkeeping
> > +		 * that is cleared when the region is torn down. On auto-discovery
> > +		 * re-assembly after a subsequent rescan the decode config still
> > +		 * matches the region, so restore the flag rather than fail to
> > +		 * rebuild a region that HW is in fact still decoding.
> > +		 */
> > +		if (!cxld->commit && cxld->interleave_ways == iw &&
> > +		    (iw <= 1 || cxld->interleave_granularity == ig) &&
> > +		    spa_maps_hpa(p, &cxld->hpa_range))
> > +			cxld->flags |= CXL_DECODER_F_ENABLE;
> > +
> >  		if (cxld->interleave_ways != iw ||
> >  		    (iw > 1 && cxld->interleave_granularity != ig) ||
> >  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> > 
> > base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
> 
