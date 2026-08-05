Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782A352000;
	Wed,  5 Aug 2026 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910879; cv=fail; b=YzAdD8Z4cXquEFuQgz0YyXggg2jVXFjnc5YzbIFUutkyjxSSBOVMkssFbz0HlbpYwYrfvHJoTNWAFqdbUs53QkuWN2rPdyBcJTp05uBCYC0J6vqA3cVj1zkgrkgKrJho4Fg4VBxA7RppkcgmqwV/ixLxZioujlwmVCKw4CvGz6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910879; c=relaxed/simple;
	bh=EvDAnTG+UVM/4OO5Vni1K+ajbUktCNM6+jsPYD1vzFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WjO34haDg9JxVvoUhaoJIhwb4Z2G9cv8/eLDawqcNWB4ziHVNpnPw1NKF1Fln7DVE6WRUeRAlL7Hghnj6dXmnrKyfMxACE3mrDmuOfVBuzA9wmGn/ttcWkiz2NVtz7UKa2haXDm5srNO8svo0wglfwvkFE2CTwj7tSLEKQV08go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4cIttG1; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4cIttG1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCvnVwE+KXt5KYPVySeCsVlzP8Ztu50jlOA3fMOU/uOKa9B14icoBbAesUNW25lTAawFqsLX/L43pSejN6V3c7ISA2pOpJOYy6GQeOKMur7DNWObgFk1zEiZ0sFGO1J21z2/3i0VkjRGhSBgmUJS3ZYyK6Xg0hLS4v6otJyUtCW7lOwCIFvaojkJlY4FJxaiTaGKepge5xCYwLv7c1ZVAjZC4kHr+GEtWuHjT6sJxAyUGH2129IAXQRMfxGhSjYsF/rSC5tj5Qw8ZJI+7BUy2tbyzIh7Pgp96+sT9A4KhC6mnm8W8F5Ve8WmsIcKgwloWRX/J9Z4wcQLLAID1Da+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqiFhjuc3iwrc4kisC2fcyCUz4ws1o1PB/3AIvSzQdY=;
 b=Cf/lC9U0x5TQzCf+M4ny/vTLfACYj2VzRCaMzvTJBSduOjhKPpN44rY1Y4G5bWZIoQmYsklRojDIGqFBh0pGM7MEoA1LzDz3YMhue929rMo1Bb8pS8dNJVfqWJfcSSd4Nrco9Bo+KgsmawmVLt5S12aPIgrgG5+AHOij9s13IUwxtNuuNygxoqznSLv50evQUXK9qRhztDFsTGrDX6AwqXTuHfJ2ANGxQUOknUT8Pc+40HbjDPom7c4ytuVd3C1t6kj8qSmbKQlqp0fQZ9ly6rpNYUhm11nNShKNg1UYC1N7yUAYhzDJr2vp15kCyA0k+bqkjwz7MvKNW6HL6UaNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqiFhjuc3iwrc4kisC2fcyCUz4ws1o1PB/3AIvSzQdY=;
 b=k4cIttG1xkzPguf2tE9vJDDHtEL2CTurqwL9zRoqWDqJdCUVE2hdpcemBY55NgxYhcJCf4Er0yG+svL+BMjVA1un7Ci6KoMz/GqfFVEZVZbF+EDCTq/aeOLqZVb3YSx5b9GuP+L55Vsgx8qGgAJFq7Pdf6E6zbvrD6c92OtxqD7YJghCx80ofmTGOwumIGJjz5cK+bR7DZSahXb4G4mUwj5gpQSz6Cb+WlLPhiBJPiNY4QfvBl1JsxkcYThLnKpEM4jtzpXYfx2ilPRWvcUc1wad3ZAdNPq+m+v0ORj21QFnnEnLXk7hpW1YZnW0/RFKCROvHBu/hgFI92cH2hIASQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:21:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 06:21:12 +0000
Date: Wed, 5 Aug 2026 14:21:05 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org, ming.li@zohomail.com, 
	gourry@gourry.net, rrichter@amd.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sreddym@nvidia.com, smadhavan@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
Message-ID: <anLVILs6MNR2lx5i@MWDK4CY14F>
References: <20260727103743.63343-1-icheng@nvidia.com>
 <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
 <amgQUnkQ1VjyXtzx@MWDK4CY14F>
 <210c8742-08db-4401-80eb-9ad9a8c14054@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <210c8742-08db-4401-80eb-9ad9a8c14054@intel.com>
X-ClientProxiedBy: JH0PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5b::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b16e96c-9608-4ba0-9507-08def2b9bedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GST2Vzni5f+azVje6UeBI7bIseBpUGUmJRlP+0H11OpMV0gBkDLNltPcv24j2g5WMPL/8evr/46kaLIuW4toI6dX5Eiwrstp+/DVsZxulfSpQEcxM8D3FjKHC3kH3Os/QuJgeTJISmCsndPZKHMuwKBv/Vj1xpaGnR7X7BCq4meSO/ZJ+IOq8wfFyZLvSVrVViDABKti8R4Id7pPnYz89nebXFalsxb/67fX7DTj+A9K0TNcPLXOuO1lwHMwUwBiisSUIq62EknBKIFaEJEz4ib9ppw/r3NTnSTWxUsqr+h2HN7st7yAU1uCc9xNO5bU+jcoup1BV+eCZSkdt4+rcHC4V+htHztLpWTwO+4qS7ylVWa9SHRTS62Aa+5j5zhRhFpZYvXb4jT0p3Axblu6OEVmpBc23PPimAMVn2mWSyz8h6V4JmpWk9QVRgVXQeSNM1NSzP9I5AoQoai0aWYQJEJOSL9oy39W2KMQpVorG/kDIbcEM46xUbtI78u7CNM4sIuFpmnxr5Ovr90XEH7gKy9bOixc12fGWPnW2wWpb7Z8tgqM1iewxDG0iLtNSJ9K2bmEyqyKC6ccfyCyA2+laW2QESmsV61mpf4GyQIXYCf4Ks5HDTVSao4QLB7lehadW+g5hYsR+xyPJMDfDU/DhD0gT7yxJm0RnCtKS4Bv6y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyLquYAkEP6wGmJa2pUp07Ln7fcJ2rj8wdgO9SnQNhVN41xT8o6nRLcbZNFB?=
 =?us-ascii?Q?s1eXPtuGTXdNLwxSDF0U72gGdsnd8Xanw6eZxMfYPSVi0mdGiPEMwmQbjvJN?=
 =?us-ascii?Q?ZKrzSoTMztfeiQ2QU796KJlkVBCNN7Kq23SuxnF7jElfHBj9GGjU7qRDhbaX?=
 =?us-ascii?Q?u3gfvuwr0Gnav9Y/TLCGvw3LTxZOSoKvoipv/797/z5ZdWPrNjz4M5BAiz9r?=
 =?us-ascii?Q?sdaRbPOqrbCMet6KqF4cGE/mFEX7Ngk9lZ3kDJzrZ53MQN/6SeqxoxVdH430?=
 =?us-ascii?Q?0sGQgXTmiD+TQoM3ShylV3/Uk6rCixN83Gpjn7OWSdbusoqWlwO25vHij2TP?=
 =?us-ascii?Q?mYMIiO84Tz6h1qalVmbHyGhw9n972kZuhVFu+AJE0eNbD5RTXwxUlbXiLaQA?=
 =?us-ascii?Q?/zA3atnCecbFvT2ki02XeJpWBwdPyXUawLsWcXJtkcTG3upcTF0Mj/lHp1rd?=
 =?us-ascii?Q?3YOjua3rFrmmUlfv2qOIcx2cBsjqVS8sUZbe1Yeqq1zGyrfGN/2qTtcOrkOr?=
 =?us-ascii?Q?ADQ7LbRHRqhwaV6s57PhTYIZQV70KXfAIGXr0yB+H9Uw61VPmbhl+caS36HF?=
 =?us-ascii?Q?Xm6OH7g6YGrg4gMlOjYqGEpfTq/bWrRsMO8zNsNCJcKo890XZaDLnqHYy4ng?=
 =?us-ascii?Q?y3xtQ33Q98eLEc7Z4a3QjN0PV4y6jawDR3A+W0YmxwXYYT+E3fv2Jyeg1yph?=
 =?us-ascii?Q?om4wDnZl2Vve6GHVb2l6/bEH//7qNErZLvfWhiUJfJhRohX8JqIhEs3kC/O7?=
 =?us-ascii?Q?mTYURRuLUyLKoUv6wmKmsD50F2aeTPPBDuBJt1Ge7AeJHJk6Fj1BwAc0kc0y?=
 =?us-ascii?Q?2PmgdhdjALyBVv5ODTq28ZMBnwfqawqiiKGsxII76ui6D2e54UFez8Z7ZnBz?=
 =?us-ascii?Q?hPGyJTqgxTRevZkHPZj4JNg/XceIyW/HpVqfd2WzxIkB5trBXw91DoWyTlhg?=
 =?us-ascii?Q?YHVP0woyyEZkoaleY8mIfb0K2oJqC3OG43Ig0VxCY+5IaJJl2pHwuwP6TEqZ?=
 =?us-ascii?Q?u/f2QN1u671c9KYRn/FH5dIeRlKK1MfgYtG3EAguLNzdkspi5dmhMA1lD6f9?=
 =?us-ascii?Q?cFgPlwJ7QAqfvUy5tVMZGHhrz8qxlAoqyxeuXQ+k82CzRWP50f3bBF2w9bVO?=
 =?us-ascii?Q?jmWVoWPfofy7WGsmeHQ+0mwGVp8aLPWplSoCBf+Gt4IfByfZTk6WURyknb+B?=
 =?us-ascii?Q?NPVEdFqfmozDEIFrNXZNSiJlJC5fk22JQOv5zD21wiQhcT1XvYNGxL+1mVQe?=
 =?us-ascii?Q?UmcrWbtwR8Rtvm3KBnCT23FJcFPg42+DsMK67sDzMydab4L9NiLUavgc0w2U?=
 =?us-ascii?Q?EDJvLzwBTgivrHpbzc84Q8NSDYdvFRA3Tax3N/we5XjrG3jG0fVnJf6PCvyv?=
 =?us-ascii?Q?hShIaQmcmwoC7zDAz2GC49iroHMfNpOTb56U7BYYsj04PRdafLmr+m7UzVlu?=
 =?us-ascii?Q?z30RHZFZbCQEdRCQDaG8lnzTtgrE14JpSDsXi+dS6qSTm5YKbYBePGvWCBmu?=
 =?us-ascii?Q?K0axdPQYuPgVvRyNZc5fwPOOQeP9Bh+ey7+TSHC3fDaW2LX3Q6fdxIg8A/EL?=
 =?us-ascii?Q?wj5LHe8eP23iCyZpCAsl0souQcTyoA+8ShFCEetxceQqEPruTm989j2XaWsp?=
 =?us-ascii?Q?DqpdY0F5Oyp0ECd6xB1TxwToANI/KUoWwnfNW4I/m7h/HZnOVuC4RsZf/8vc?=
 =?us-ascii?Q?aq2tFikaL6iLjyNzv+2nei2CoAXKAxYtgiPSOpI7JszXsP4tUC0bhZF565X3?=
 =?us-ascii?Q?GjMyp2zulw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b16e96c-9608-4ba0-9507-08def2b9bedb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:21:12.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8SEjKd8L213dgZBW1Gm+1OrQfDIp8q3mKnX2ENIoZeazqqz9tSxpMAS9J6JR7XBLia0rYn5jiDMkzDoP1+fGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177

On Tue, Jul 28, 2026 at 07:25:09AM +0800, Dave Jiang wrote:
> 
> 
> On 7/27/26 8:03 PM, Richard Cheng wrote:
> > On Mon, Jul 27, 2026 at 01:25:48PM +0800, Dave Jiang wrote:
> >>
> >>
> >> On 7/27/26 3:37 AM, Richard Cheng wrote:
> >>> After a CXL endpoint is PCI hot-removed and the bus rescanned, an
> >>> auto-discovered region fails to rebiuld and is lost, evne though the
> >>
> >> rebuild
> >> even
> >>
> > 
> > Hi Dave,
> > Thanks for the review, I'll fix the typo in v2.
> >  
> >>> device's HDM decoder is still committed and decoding.
> >>
> > 
> > I think this part is talking about physical remove/insert ? sorry maybe I commit message was too vague about the scenario.
> > The case here is a SW-only teardown via sysfs, this is what I did.
> > 
> > """
> > $ echo 1 > /sys/bus/pci/devices/$BDF/remove
> > $ echo 1 > /sys/bus/pci/devices/$BDF/rescan
> > """
> > 
> > No physical removal, no power cycle, no link-down, no reset. Linux drops and re-enumerates the same device, which never stopped running.
> > The endpoint HDM decoder is still committed.
> > 
> > The device is byte-identical before and after, the kernel doesn't clear it either, the decoder is locked and cxl_decoder_reset() returns
> > early for CXL_DECODER_F_LOCK before touching any register. The memory keeps decoding.
> 
> Given this is a single target passthrough, should we check the EP decoder for lock before going forward?
> > 
> > I don't think anything needs re-programming here? the only thing lost is kernel-side bookkeeping on the passthrough decoder, which is
> > freed with port and reallocated with F_ENABLE clear on rescan. The endpoint recovers its state from HW.
> > The passthrough decoder has no HW to recover from, that asymmetry is the bug.
> > 
> >> Also, a complete different device with possibly different size can be inserted. And the device showed up would be unconfigured. Given
> >> there's no BIOS to program the device since the OS has taken over, should it be still considered part of the auto-region?
> > 
> > Agreed that would be wrong, and I don't think this patch allows it. A different or freshly-inserted device fails the existing endpoint
> > checks, its own decoder won't come back COMMITTED with a matching HPA range, so cxl_add_to_region() won't re-assemble the auto-region
> > relardless of what the passthrough decoder's flag says. This patch guards on the decode config still matching (iw, ig, spa_maps_hap()),
> > and on !cxld->commit, so it can only ever touch a SW-only stub.
> > 
> > So the coverage here is SW-only, I should state it more clearly in v2.
> > 
> > Btw, the check "!cxld->commit" is doing a lot of implicit work in the code base, I think that's worth fixing regardless of the patch.
> > "commit == NULL" is not unique to passthrough decoders, cxl_setup_hdm_decoder_from_dvsec() also sets "commit = NULL" for DVSEC-emulated
> > RCD endpoint decoders, and root decoder never set it. My call happens to be safe, but that isn't visible from the condition.
> > 
> > I would suggest an inline helper like the following, do you think it's reasonable ?
> > 
> > """
> > static inline bool cxl_decoder_is_passthrough(struct cxl_decoder *cxld)
> > {
> >     if (cxld->commit)
> >         return false;
> >     if (!is_switch_decoder(&cxld->dev) || is_root_decoder(&cxld->dev))
> >         return false;
> >     return to_cxl_switch_decoder(&cxld->dev)->nr_targets <= 1;
> > }
> > """
> > 
> > There're about 4 call site today, and it distinguishes "passthrough" from "has no commit routine" , which are currently the same check
> > for different things.
> > 
> > Happy to send it as a separate patch and make this one a patch series if you prefer the shape.
> 
> Yeah I think if we can improve the clarity that would be a good thing. Thanks Richard!
> 
> DJ
> 
> > 
> > Best regards,
> > Richard Cheng.
> > 
> >> Any thoughts Jonathan?
> >>
> >>>
> >>> A single-dport host bridge/root port has no HDM decoder capability, so
> >>> its switch decoder is a SW-only passthrough. Its CXL_DECODER_F_ENABLE
> >>> flag is cleared on region teardown and never restored on rescan, so
> >>> cxl_port_setup_targets() fails with -ENXIO.
> >>>
> >>> Re-enable the passthrough decoder when its interleave and HPA config
> >>> still match the region, it holds no HW state.
> >>>
> >>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> >>> ---
> >>>  drivers/cxl/core/region.c | 13 +++++++++++++
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >>> index 1e211542b6b6..011ceb5bae79 100644
> >>> --- a/drivers/cxl/core/region.c
> >>> +++ b/drivers/cxl/core/region.c
> >>> @@ -1574,6 +1574,19 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >>>  	}
> >>>  
> >>>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >>> +		/*
> >>> +		 * A passthrough switch decoder holds no HW decode state.
> >>> +		 * It's CXL_DECODER_F_ENABLE flag is pure software bookkeeping
> >>> +		 * that is cleared when the region is torn down. On auto-discovery
> >>> +		 * re-assembly after a subsequent rescan the decode config still
> >>> +		 * matches the region, so restore the flag rather than fail to
> >>> +		 * rebuild a region that HW is in fact still decoding.
> >>> +		 */
> >>> +		if (!cxld->commit && cxld->interleave_ways == iw &&
> >>> +		    (iw <= 1 || cxld->interleave_granularity == ig) &&
> >>> +		    spa_maps_hpa(p, &cxld->hpa_range))
> >>> +			cxld->flags |= CXL_DECODER_F_ENABLE;
> >>> +
> >>>  		if (cxld->interleave_ways != iw ||
> >>>  		    (iw > 1 && cxld->interleave_granularity != ig) ||
> >>>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> >>>
> >>> base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
> >>
>

So I re-tested those operations on v7.0-rc2 kernel without the patch, we find out

0a70b7cd397e ("cxl: Test CXL_DECODER_F_LOCK as a bitmask")

This patch is not needed, and Gregory is right that intermediate decoders should stay locked and
not have F_ENABLE cleared on teardown.

For v2 I'll only send the cxl_decoder_is_passthrough() helper that Dave asked for.
It's just for clarity and no behavior change. This mask v.s. index mistake already caused one bug,
so a small helper that hides the raw flag from callers seems useful.

Best regards,
Richard Cheng.
