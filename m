Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885837B3E4
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997019; cv=fail; b=VTDE7D7K7b+eRSPHBDlV9bUlFMx4zUtxm1+Sh25TBAbTwjrY8dgdA8Ng+oIpdLlurvnNLiz8Lo+ku0OwMmJt6HNnOnX0MoeSvzXEJqSZTMYn8WBPY1ph/Qd3s0d9+ueZTIZf2XAdT9ymBR6gC0Cv2gevWLnPCrc4kG1OxzsxyCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997019; c=relaxed/simple;
	bh=LHo2uuf9MRiewzRr409xp2gy85CqY61OGgWxmVKc93g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QYVgTYaRqiI2dwAF6nTXGh5cprt2XYFpB01YKAUvewy4KCbTgR4wigq4z1BNd4Oyh7zjzu2N7/QKzBT1NoFJPVnfWc1yclz+8M+ldHcsqvpCA6BX3gHcHU+0hf4fOHRgJcLRVhRkrpRl1qK7oK6HVHIfMHaSYV3+NujIfza4lTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgWPXFO8; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgWPXFO8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5SqeDAIO+TQ+EQoXSzfPXUKitted6ybXs1okPxk2wLbURjBK7H/pF2730J84vNmWHfDC3GLz0m0XH9vvSU/YttqSd/eCUHoA2r1jc7T26Jqg9Mss7RaQySew1789MPikMGdkpzFe3oGEnJ0IYhJWF19UeVVpaDwNdMS74Bp/mtiwBQ1FUrdJ03jFFNDyOzz3WK09Cmb+bV3mCwj6MzQC4HER4B9xSeyzufbSCvZPE55xjXnJuLZpeF77peae7QALWdY2g2qePamB47I2Ni9CT8r6hcxiLzqNP73QiBFhymvK2arYMiP/bWrTNbcec5DYp7wjYuKy4rPa+5RE8y67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkxSZDAAJUn7VWxiEE66tBR/6tq4cyAJEWlO31grQ3I=;
 b=llceIuqhlwwEgjtBKiOrMvhgtmp+PEkhQSrBt+JEBjivgQjnNMqGnef0T+st5I359PoFc13ZLP5EN2QQVdE8axWSQd8RYW0CYIIOaHjnIMZgCdMq+F3B7WBljx6Xq/eWrwjQBptF/0RsLI8V1suLjwZG9EPxFApGwAAp0ZZUEgiEUobNdVh6NxNyrMj9bGtuQMxUufBIxQ79lNMN01F4TBSc29CAJW2atDr0DwlxXvkBWE4Q4Ma6IMbolYdrbyG1WLGEWhDwQx7wb2opKQEbfCUXy8R5Put086FJ90rtU+sNGtBYGwxaKNrGvYC+V8urYlWaOFd3xJZQWtFPMc4NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkxSZDAAJUn7VWxiEE66tBR/6tq4cyAJEWlO31grQ3I=;
 b=PgWPXFO8vmCUZj5yK+0kFgNKl4jJZio06OBDmFZhaiWvjNcG5vNnEa3SL6kZe5WDbBPpJZTrN4WvI6eupy15tX9M+VVKh6PkHGEM/lbQDf90fNx0FT2tKjdFm5qL9YZPUHGRrkr+9jbDr7hnqoPBF9gnm/Q3PyQpx/BbeoBo4rs8Nwg/Gn28c9eq1ZGpQYDuUJ0NXUV7jXocAKq9iMXqV+vlso8Yza1iC1kGMHlz7445QqL3QxwXvB3UBIVM/jXJdiO4a/VNqNsHOo+jltL+3TytFksgMF06nvfpcoKniLaZOEVxDoi9NauGUmQ7Qe3dAvAbS565XDAFEh1hgWI/qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 02:43:28 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 02:43:26 +0000
Date: Tue, 14 Jul 2026 10:43:15 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net, 
	jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/features: Serialize multi-part Get/Set Feature
 transfers
Message-ID: <alWh6t55hy_vqJPV@MWDK4CY14F>
References: <20260709155841.1895915-1-dave.jiang@intel.com>
 <alS0YGIqRfGBVCWl@MWDK4CY14F>
 <ee673c37-e6bd-4321-8b76-a26a89e0df08@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee673c37-e6bd-4321-8b76-a26a89e0df08@intel.com>
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc1f5d9-ce78-4b33-906f-08dee151ad26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|3023799007|6133799003|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DccvQmbczn8mBXmUKTNetF0ADrr67lqhYed8OwOa/7wrn/GgjVUGSoBsNvol2THfKZHIzL8YxIMxwonNVlVf0hdt+PAfJN52H80i8CDun7C678d8x/ZyWJh0mCp9nJ+xDHPnBgtorFWvSJJBHwE0MsZ3Vx51cPVlVG1QMU2ApduwO3IqHAIPKXY+vpfVaq2RGKbEAX/rfkSGR71KUiURQ0LW4DFXzhasECWMO7pHFvr6wG0BYQcmIgOpIbqU60If2Jy2UdbgENTO9wD1AFHg5feP1iJBLu6gu4NnD4wC/hzvjRK9dvA2ucESN40k9mMagpUt/LquWCp/KJDQduMhFdDtxl/XPFxKEkVim1eUj7Vkwejzd+kqJRJoqQQugQV8mtGuagb9Blxg14aWCeO5LPGnw3FfFkGrnhJKZqhaGnWzyX76pjpSUReVLi+EMBgcC1r/oasr5TD9Tyq9uGmfQBPQT4OlWFwPokP9HUgupvlVuF9STpHQ6lRFsfAwc0Sj53GP2+tjZ3TC3X16trgEdGZ59Lqi5RQuIdzt03UWjPm7ag4cJivTzHIsoonLfojCVzmjlJHt5K2SBYKtFN8iSUQ2zjYQ3dqwSKRim9jSm0LZ6Kel8IdFydCrZO1MKtAmx6L19AzENUqQDnL5og9N8Yn+qNZ4jyLqvXKnVkP4dyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(6133799003)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?givFAhXwgBl2Ipb76j7sxTL5T/kY+TTgs0oW/5DnzJ14P/Vjs6+v4VkWUoFe?=
 =?us-ascii?Q?Q00Cyp4mA983CetwtN/r2wMFazV4hyFd9bPRkvhb3eTxPBRW2BqjRqVolxdI?=
 =?us-ascii?Q?ilwELMwhW0dH556EJlWyEFM8jHfL6LRQyVpZiGxpkzByQry5fTPc4q3Ialg0?=
 =?us-ascii?Q?EwPN+2/VRG4ZWHXcp3L0Ot42YWaTwFAI5JoAVITXS086MzZ0HxgvVa5wNUmI?=
 =?us-ascii?Q?XKSV0qWixC59mPJ9w4n8/KGmitecVgRA9q0rAEW1bX1CUQHqrCBj/RjSpe7/?=
 =?us-ascii?Q?sLrtyj11eNdZQGEGFuqaXHytKPiIiMMR24oOFYhUdnveo1WmgZKkyQ4HpPCw?=
 =?us-ascii?Q?Fq3hIXQWdPtu3uRWT6POKVRRf/7tZ1L2BIEnP2iap1R5rZyoOWvwfAObtMOd?=
 =?us-ascii?Q?6pOGLQ/rGrZjNUAfg3IMjvhWVoeZ3ZkDlc0Zn2Cg3UN/Trfg7MSTCH77+eJX?=
 =?us-ascii?Q?NX/SRy9i2k7MNCpplfmElF1euiVj4iGDqczRZXVwWjRmIUmzu/qE4t84UKLX?=
 =?us-ascii?Q?ViVjOVauJ1nF+8+V8K/OlimCTrIJJb87tvzLPUQ7Ap04usd2fOuXoSfV1uPJ?=
 =?us-ascii?Q?v5Z4edFesaTDnV0msVVT37G/FEf78whF+pusGmLC/aMttfmguNhovehNKUSo?=
 =?us-ascii?Q?D6qqEy9OQfHwQe+NA0CNmvV8/vTHYEp5qrdXFjS3Dpud7XfLffuOzHlz+WnY?=
 =?us-ascii?Q?hbwxkYAIIGdd/8DHRCcTeythQY1X/sUzWQaFDerbdZIMGfTozPwXVdCxYHxf?=
 =?us-ascii?Q?2f+YTfLQDfYC/wM4NvbMKKAJCApooSWAi+tAkMWKHYuR4L2a5yJ+Y/UH8Iti?=
 =?us-ascii?Q?uyM0d6R22LxdIvln+7pnHROY3S82oZ+AYz5t4evPpVXYfPQV7GmDoPWrIt99?=
 =?us-ascii?Q?5OthqPa5RIkH6qik3lrRVls/Ov8Yz9rzCOwdsjSxbwbRapvQaZSEENAxNxI0?=
 =?us-ascii?Q?DI+5fktkS8f3Q6so5yv3DrbC3oynjXDN61EVn2P7nbu34dx3ldKr/s2fp5hs?=
 =?us-ascii?Q?2h9/zMR6xtDbNjgjobMF0i3nFAxA7EJ7BgnjErJKAOTFSyxogL+BYXVpfGKg?=
 =?us-ascii?Q?gwRHZHlPVZI26wY3WP3wwsRE4WxYvdhmgxD9YXgLP0KMYzwJMCl37o1rFRM8?=
 =?us-ascii?Q?Xj97xZ9IPABPZH9UHCwv0Yx4dbSan1gjomIcCYxDBsC1Qnn1Z+xNuqGItUnO?=
 =?us-ascii?Q?2YYKDHY57XehjlQw4OZ5U9tYO2jDmESPoUi7octwQuN0RkzYAAM+qxuEQPJe?=
 =?us-ascii?Q?VUvcvCGEy/G9pjrH5QKxAhFWi8Znid0zbIHU3yVbENuYS2YisqUiI+4Dz2nL?=
 =?us-ascii?Q?oVtkFMWETzvIfXNMoqneLXtqICw87R6IWBPWJm6vvbigh8wE9Arb8pBWVX4R?=
 =?us-ascii?Q?Bz03sIIj+suXyqV1AKvqcXOp9+VQ3tf9wINhyJqYZbCbX7/oTMyh8SKjB3dH?=
 =?us-ascii?Q?btVub+ZnIQmvyxyV91SjhActe1E1doaHFlRS3IwN5PBrfFVGGAVEDKUW4Xov?=
 =?us-ascii?Q?m+BS3HNs1GQ7q4Sn4iGbRrgVCuuXkK3ijDHW9cYdNeBZUwqflWGuW2isUYxi?=
 =?us-ascii?Q?mn1oOaZAE/Tbo5DQwteB9Q5lyWzo0VMzTQD/3BJiE+xid/wUbbo11WroXY8x?=
 =?us-ascii?Q?BDI8SeqOjQbSEUwqM2nIOJ012PaVCECrR8t+Leo2DUieDlAiaCW+aYkzeAYL?=
 =?us-ascii?Q?HLto8eNEV5dBM2Fm/Cp5XZybHMacEA+U9Q6uEHjZyB9JRchB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc1f5d9-ce78-4b33-906f-08dee151ad26
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:43:25.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOr8Coyf1iBFRliRk7lktMGGWcBA4fYbSb99XXcwDbKA4fCD4vbNTTQcgEqo/tkjfo3cN5MnYsCB4psrL7sW/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609

On Mon, Jul 13, 2026 at 10:15:07AM +0800, Dave Jiang wrote:
> 
> 
> On 7/13/26 2:52 AM, Richard Cheng wrote:
> > On Thu, Jul 09, 2026 at 08:58:41AM +0800, Dave Jiang wrote:
> >> A Get or Set Feature payload larger than the mailbox payload size is
> >> split into several mailbox commands. mbox_mutex only serializes
> >> individual mailbox commands and is dropped between iterations of these
> >> loops. Nothing serializes the multi-part transfer as a whole.
> >> cxl_get_feature() and cxl_set_feature() are reachable concurrently
> >> from fwctl (per-fd RPCs run under a read-held registration lock) and
> >> from the EDAC scrub/ECS/repair paths, so two transfers to the same
> >> mailbox can interleave their parts and corrupt the device's transfer
> >> context.
> >>
> > 
> > Hi Dave,
> > 
> > I have some opinion maybe worth discussing.
> > 
> > Get Feature does not have transfer state, it uses an offset and count.
> > For Set Feature, the device must reject a second transfer with Feature
> > Transfer in progress.
> > 
> > Maybe we should reword this as preventing concurrent Set failures and
> > preventing a multi-part Get from spanning a Set update? I don't think
> > "currupt the device's transfer context" is accutate.
> 
> I'll update that.
> 
> > 
> >> Add a per-mailbox feat_mutex and hold it across the whole transfer in
> >> both functions. It nests outside mbox_mutex (which is taken inside
> >> cxl_internal_send_cmd()), and is taken nowhere else, so no lock-ordering
> >> inversion is introduced.
> >>
> >> Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=1
> >> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> >> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>  drivers/cxl/core/features.c | 3 +++
> >>  drivers/cxl/core/mbox.c     | 1 +
> >>  include/cxl/mailbox.h       | 2 ++
> >>  3 files changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> >> index 85185af46b72..85d6bcdc360e 100644
> >> --- a/drivers/cxl/core/features.c
> >> +++ b/drivers/cxl/core/features.c
> >> @@ -240,6 +240,8 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >>  	size_out = min(feat_out_size, cxl_mbox->payload_size);
> >>  	uuid_copy(&pi.uuid, feat_uuid);
> >>  	pi.selection = selection;
> >> +
> >> +	guard(mutex)(&cxl_mbox->feat_mutex);
> >>  	do {
> >>  		data_to_rd_size = min(feat_out_size - data_rcvd_size,
> >>  				      cxl_mbox->payload_size);
> >> @@ -314,6 +316,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> >>  		data_in_size = cxl_mbox->payload_size - hdr_size;
> >>  	}
> >>  
> >> +	guard(mutex)(&cxl_mbox->feat_mutex);
> > 
> > What about RAW command path ?
> > With CONFIG_CXL_MEM_RAW_COMMANDS=y, GET_FEATURE and SET_FEATURE can be
> > sent directly through mbox_send() without taking feat_mutex.
> > 
> > Or you want to keep the scope minimum so RAW path is out of scope ?
> 
> Yeah I was only trying to fix fwctl side with this patch.
> 
> DJ

Hi Dave,

No problem, then I think I can handle the RAW path part, I'll send v1
later on top of this.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

--Richard
> > 
> > Otherwise the locking and ordering looks correct to me.
> > 
> > Best regards,
> > Richard Cheng.
> > 
> >>  	do {
> >>  		int rc;
> >>  
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 7c6c5b7450a5..0370ac39ec4a 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -1516,6 +1516,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
> >>  
> >>  	cxl_mbox->host = host;
> >>  	mutex_init(&cxl_mbox->mbox_mutex);
> >> +	mutex_init(&cxl_mbox->feat_mutex);
> >>  	rcuwait_init(&cxl_mbox->mbox_wait);
> >>  
> >>  	return 0;
> >> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> >> index c4e99e2e3a9d..d008b9db07aa 100644
> >> --- a/include/cxl/mailbox.h
> >> +++ b/include/cxl/mailbox.h
> >> @@ -50,6 +50,7 @@ struct cxl_mbox_cmd {
> >>   * @payload_size: Size of space for payload
> >>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
> >>   * @mbox_mutex: mutex protects device mailbox and firmware
> >> + * @feat_mutex: serializes multi-part Get/Set Feature transfers
> >>   * @mbox_wait: rcuwait for mailbox
> >>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >>   * @feat_cap: Features capability
> >> @@ -60,6 +61,7 @@ struct cxl_mailbox {
> >>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> >>  	size_t payload_size;
> >>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
> >> +	struct mutex feat_mutex;
> >>  	struct rcuwait mbox_wait;
> >>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
> >>  	enum cxl_features_capability feat_cap;
> >>
> >> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> >> -- 
> >> 2.54.0
> >>
> >>
> 
