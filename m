Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACA2C1788;
	Mon, 29 Jun 2026 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699184; cv=fail; b=szYpn+UCBKYPOgaddnoDn+bKO1SBj+2K3DXLX7h+JSVQ4mUIUkcweTx//O2SQMy/nnphjxC/Dw0Iv1Qf6ikQkQ8MW1sq/6BrgLJ22Svd2I0NlbVs2nY3hxZ/bv4wbdwlgxiQ8vMuOfGNNuLKa/LXZGVqiorAWn9nqI198QMseF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699184; c=relaxed/simple;
	bh=rqjv105CxRyc0y5fIVupvyxuUMFrqusrOGDKhweMYS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPXQQRgoIGbqUlobqzN5ehdr5FQtUD8neeS3JfPrmc0mv8y8Uu88TapgMPrVJQ4zdLvknPU3xw4ZWjM2J+UOtnV4sPtCcClBQdsPYhQEmSGTPdugBPxbxkDz7hxNGFzmzTYt3dBmwhHjb1SRXjdZ40gF08TVEkXD3QbHbdXy7LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TO+896Ip; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TO+896Ip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViamrKBQhmM2iOv02hERyRgbWOuFCsEaTw86ctyQCEc7E90eNb8h3539ClDX1T5B1llYe9oBqqovWYB+vk0Tepb/59IzT+4reiT945+eU6Jjv/RyY97snC9u7fnyYGovg1XDH+dt6/Eyy/aCjrpugmlxeQR8VtYkg2zGblUYjWM4osjV6LVF0fejwCTXOTcop1n3EWyV1v9nO5nrQ7gacEp9hdGEcZjo3j3DofKZYjSkOUlYe5YWzx7peuKL6cse1XW7llwSHLBWuWauAPVRjM9I85hEqNPJjbXaK/gDWDYEU/UDFQmZtWRK2oQs1I+8t60d2W9ecAbKRiZYS7c9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR/HRx7l4qZIMNyJjvEnJ5HGD23UMSqCCNTYlQpGJMc=;
 b=uR+lDpdiFkcS0hNWW9r3NdrbjJ2GZyJQRn5IO873FiZfuaURzy2HW+N5+6Y1JFbWF+PAnBTP2ra6iyEZN1PRyLVj1GGLD7XTHW/3yD9RwWkiVV88aFxYD1MZBJwMJmSEb3cJJWiw3NNa3BwqAsqsc2r6g+CeU4w+vzJ8Rfhgu8YuJZSnwiA1NTYXwkYldczZQ9Dsmr49Sfb/aSv6+/1Cwrjk5Xo8IAgxJ13Ux/fxo1XQDcrFnE8iQR4U9auOA1/ykkFt06SqRb6ZXO54v4wln+zPeyZjmvT+Q/+PpUVj9fdgvL7cw5LrrovmCTYOzm/hPdVuXZz3DquNCdsKb9X2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR/HRx7l4qZIMNyJjvEnJ5HGD23UMSqCCNTYlQpGJMc=;
 b=TO+896IpJA8ltWhojy9uDLJ2Jt7Pp+X+u94mDqVDtJsuBHeD55FK+DoEP4YusfAymuuPKu0ZIi7CKOvSzCAt1IKz4687BIvt3BPypNyS4tEIXEQ5sAmfMCOTJ4i7yIOOlik2GaJAjvMdo+sEQhKmNUCBlmDlHqgBKlqcxj+vSh3JR6NW6jdne2hSZv5J/WGmlRDmDD5SbVafUgkD2ksmTCGd+QNhSgrmgVethNdcBpjuStOcT6n+h96bzOAe2xp/buiOht1ir7lVRK2Pv/deJLpmMKZ+m4IYu/nnwn3lK7Gai3qy0j9EQKf3L4DEwK6jGkOl4alUhWUhxJWdpV2f5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 02:12:58 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:12:57 +0000
Date: Mon, 29 Jun 2026 10:12:50 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Zhenhao Wan <whi4ed0g@gmail.com>, dave@stgolabs.net, jic23@kernel.org, vishal.l.verma@intel.com, 
	djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, ming.li@zohomail.com, 
	kobak@nvidia.com, kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than
 the output buffer
Message-ID: <akHUATTw75mXrjWn@MWDK4CY14F>
References: <20260624134737.49166-1-icheng@nvidia.com>
 <ajxEGmGxOhryENl4@aschofie-mobl2.lan>
 <ajxHwh3s2lM98aed@aschofie-mobl2.lan>
 <aj4pYfg51dWr__mw@MWDK4CY14F>
 <e97b6cfb-f6e9-4be4-aac2-121330b6c56d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97b6cfb-f6e9-4be4-aac2-121330b6c56d@intel.com>
X-ClientProxiedBy: TPYP295CA0005.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 909abda3-5d51-4aa7-c62f-08ded583efe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eU9Bp284tDOgjUm05nUVfSPXce73wotlOnCG0e9qNZPTpLdBTpUE4T6KQ4dKmlO9+XGh15xX57S7Id66yZ8c1rvd8gF9qaYWdAZyUsptZdG098QBfWwY8MiwasOHmxn8fD+u0OLgyOrCJZfqYfNVwwqyN0NIRjSVWdaxcHINTaBRspK32Mvj2AIWQIEUnxQsuqvzWcVJuLI812Q7kXGq6jj41H++vgyS+lQUH19LE1aihWpnzkCbuv0g3t6eXJxkMNrfyaIBjm962ky5BI3C9UL5bRIY6Ki9KNT+QlKFKIOAt7YGkr9keTZjhS7NUV0HrM7/2yHGWrE8LrHxDphlFCwW6ZPPs7rGGxCT2iZAt70K2XfY5nET5aDve/lAJL3mX2OWSfPxmKLCm/yi29N3Ki7PsvS2bn+qX1ieITGcJJlvpDSGK2wKD6Q+w7AOcB1N5u0cFcjzqe8ftdrNv4rdZPOzjbjlWqBT2q7ZBaFJM7LIHab2+l/h+qPDHeVMpsWRaTOpqks0R6H+hLydBYo1CbO5LFnMagGyrVw+wHt6Edp0Aa5Q/2mj23S7GVqhbFcWi/1k0gDS3GnCmoPqS7CcA1uGUf7JwFJZfDrPx8OE20oocICgbbfgf2gGM+MpUcwPdWO+XJl8fQiaVnez6Ow5IPS3pJyk9ar6DgCQhJ4S/Io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHmwv+pU+b5LDDLy84RTRcX87d7iSH0/XddjxRp3uiSxRKva99cPFwusLyDN?=
 =?us-ascii?Q?LHJzxLFpncPm1NxHUeOcWCFm5tc1Gp43pr89R87vpVkp3VeKT6qMUymQmDMO?=
 =?us-ascii?Q?vRSI0Th+4FB57YgHqcSboSNiisdEpnHg1VgpgzVBoDsPcJM6ANHIc9jQS0Ql?=
 =?us-ascii?Q?IG+jExjaRUvrwrzy4XjWdyzhb1dtJbZZV7k7dxwLgaWBdL4AV1b373erJ1Bj?=
 =?us-ascii?Q?jxz82hFSVYUBJkQwBY+mw4AXtFrH5vesysX+QK0nXCwy54YrgFpgJqsmkdyM?=
 =?us-ascii?Q?FTh6fT3HrwufmxenXQ7+i/BIAXJyUeenqP8wJ26YvxpjQY+6bwHTWdNlphHL?=
 =?us-ascii?Q?aR1IO+ESKM5NaX9gSUT0M8e7IwTdwsDwaHDNyPC3Pk6rRMwKwTiJFG/4xmYY?=
 =?us-ascii?Q?nlbl2oe3YeXEClmhc+p29uRXq/P29ZxpA7LRD3fLK00zVU2kIpRmhF9PDZ/1?=
 =?us-ascii?Q?yeMi91LAGIxSvR1QSCug4MA58DX5aqp2RXpOU1chxbIKS6HuAtvq3gHcsXpT?=
 =?us-ascii?Q?QZQaPnoYzGl5Tzk055zSzGJLXKDnMMuMnciIfi1/mOwC0pOpMZsq/22H+x7u?=
 =?us-ascii?Q?I6W+bltsZW0EYw2eRc3XPZioBGuRlK2gN1/QE4ocdlxCDJX0qPd7W7Hd3KL8?=
 =?us-ascii?Q?BgMsoJoXMiyQWxCr22rb/CtFA5o8nKNp5USU7djRg3B4vgFES7v2WabFmOar?=
 =?us-ascii?Q?z7Y3Ertcue5i6yVaGDTzxiOBQQqrnqG4QG9iR5NhGOw0gBkY3sIIJlM9ImlT?=
 =?us-ascii?Q?T2ZzcSyaqAVegnsn5F1wwbVSg4Y7/XVQC/AbNGpYb5L6oXu2y3F/6t9LC/gc?=
 =?us-ascii?Q?ih9y17Mzra7mX5zwdeJprbId07KBiDaT9Y3a/iiXo6UKyeC7xZxThk0P4N8d?=
 =?us-ascii?Q?L3K9QrVXzP6UX4Js1O+NQTRth1T20ojihbVxyvjgCpf/mKMoogaMzAvYYiPh?=
 =?us-ascii?Q?QKj/YjikQV6gZZa86279Sf6Z7JcrVgzFj7c4Db+LhHU25V0CdUhCrfNKccBE?=
 =?us-ascii?Q?Ni6wuaOZXSgsBQx6/FjTFBU6D2WCCFrZGnIaBA5L+SavYzqO8qcKzIQMVIWl?=
 =?us-ascii?Q?eZazcfrge3idi9PriUl1EMr+Kiw/03tnUTjcujkoLHjKW8hRtGmb48iRuJ7F?=
 =?us-ascii?Q?OHJqqy4+gdov1qmBUEAZApM+Hnxq8t+gxyhWeybkcbHr1JDrDH1Y+QHDOo40?=
 =?us-ascii?Q?NAlOzAZrgEEqnxtU8lDJaOtCymMLhdwYsAaKPXL3Yd+qJoCOMYgXjJb8/rXB?=
 =?us-ascii?Q?XROZGAQ7cj+UH7HHK7EJN9nigYvzPEg1KULjpRbjXDLYzK2KhcuNN9EodhqA?=
 =?us-ascii?Q?o60KSOWbRMgB9U+1j3LH0gGnXbroNnou1BkUKW6f7ZMjz5aolyx+yz6pqpGX?=
 =?us-ascii?Q?V+KbGkGe+MblBW1etFO5w3hcq/Q1zxQ7PG9TNEyXxayZEGBW7SJqD1AkFLZC?=
 =?us-ascii?Q?UQzoDNH+govm+05mym487N/k9PX3zL6qJNao0C6CTbI5E9LaJN7Ept6Gwn5L?=
 =?us-ascii?Q?x+xYCGlr6IZImQz6O003FYJVEQ4THTAUuKr6MZL575r3iI+ydyavhHvx4rRm?=
 =?us-ascii?Q?X3ZVi/jS3Ea6esA/9Qsxfh5EugaAKZpL5yDvFB3ftj2TMSc/jRNXJjzRrNUp?=
 =?us-ascii?Q?kvnhgkZYxMr7I1eVc+bOCoM6bGKxRciYfHnO6MxiYzUU8xV4EpWbMRWzj3gZ?=
 =?us-ascii?Q?OBDnFjS4hwZ8IV69qwk8yJ9NuG6ADpG60rCJMdyCzoUBCpNc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909abda3-5d51-4aa7-c62f-08ded583efe1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 02:12:57.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPwHAMXHNx1X7hB2D3GyoKoV+O8ExkMBLElfIWU13WeGz0Ko3mOlFzooEgmvJvT3atJLnhscssjgFkrUXUgo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479

On Fri, Jun 26, 2026 at 09:17:03AM +0800, Dave Jiang wrote:
> 
> 
> On 6/26/26 12:27 AM, Richard Cheng wrote:
> > On Wed, Jun 24, 2026 at 02:10:26PM +0800, Alison Schofield wrote:
> >> On Wed, Jun 24, 2026 at 01:54:50PM -0700, Alison Schofield wrote:
> >>> On Wed, Jun 24, 2026 at 09:47:37PM +0800, Richard Cheng wrote:
> >>>> cxlctl_get_feature() sizes its output buffer from the user's
> >>>> fwctl_rpc.out_len, but the device is told to write
> >>>> cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
> >>>> separate user-controlled value. Nothing bounds count against out_len, so
> >>>> a small out_len with a large count overflows the kvzalloc()'d buffer.
> >>>> A heap OOB write reachable from FWCTL_RPC.
> >>>>
> >>>> Reject requests where count exceeds the available payload room, before
> >>>> allocating.
> >>>>
> >>>> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> >>>> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> >>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
> >>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> >>>> ---
> >>>> Changelog:
> >>>>
> >>>> v1 -> v2:
> >>>>     - Drop the reproducer and trim the KASAN splat in the commit message
> >>>>     - Sent the reproducer as a regression test in ndctl separately.
> >>>
> >>> This patch itself looks good. Looking at the other bounds checks
> >>> Sashiko suggests, I'd rather see this all fixed up in one patch or
> >>> patchset, rather than dribble in as multiple patches.
> >>>
> >>> Maybe it all fits into one patch, like this:
> >>> cxl/features; Add bounds checking for get/set feature commands
> >>> or maybe it works better as a set.
> >>>
> >>> Either way, doing in one swoop would be nice!
> >>
> >> Oh, seems I'm reading patches out of order.
> >>
> >> Now I see this: 
> >> https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
> >> which looks like it covers one of Sashikos's complaints.
> >>
> > 
> > Hi Alison,
> > 
> > Thanks for pointing this out.
> > 
> > Then that would be no problem for me, I'll append my fixes with Zhenhao's patch.
> > 
> > so my original fix + sashiko's complain about cxlctl_set_feature() and cxl_get_feature().
> > I'll put them in my work and send as a serie.
> 
> Hi Richard, I see sashiko pointed out some existing issues on the series. Will you create fixes for them or should I go do that?
> 
> DJ
>

Hi Dave,

I've sent out v3 of this here.

https://lore.kernel.org/all/20260626104102.53892-1-icheng@nvidia.com/

I've made the fixes of the bug sashiko-bot pointed out here in that serie.

I also see it's mentioning more pre-existing bugs on v3, I'll do them in seperate patches,
or are you refering to the issue in this one ? if you're talking about the latter, I've
included them in v3.

Please take a look while you're available, thanks.

Best regards,
Richard Cheng.

 
> > 
> > --Richard
> >  
> >>>
> >>> -- Alison
> >>>
> >>>>
> >>>> Best regards,
> >>>> Richard Cheng
> >>>> ---
> >>>>  drivers/cxl/core/features.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> >>>> index 85185af46b72..9c714ee42a41 100644
> >>>> --- a/drivers/cxl/core/features.c
> >>>> +++ b/drivers/cxl/core/features.c
> >>>> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> >>>>  	if (!count)
> >>>>  		return ERR_PTR(-EINVAL);
> >>>>  
> >>>> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> >>>> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> >>>> +		return ERR_PTR(-EINVAL);
> >>>> +
> >>>>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> >>>>  		kvzalloc(out_size, GFP_KERNEL);
> >>>>  	if (!rpc_out)
> >>>>
> >>>> base-commit: ef0c9f75a19532d7675384708fc8621e10850104
> >>>> -- 
> >>>> 2.43.0
> >>>>
> >>>
> 
