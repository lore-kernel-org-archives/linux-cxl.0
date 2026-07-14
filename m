Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F592931DA;
	Tue, 14 Jul 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057455; cv=fail; b=YtZHgQeBv8RekyAZPS8YR5f+NrSOPDgFhkr9oypqG8P/Olo14Vzw7xzuOR2v4egZD1zKCosKRPSMG8n4jKbr7Z4L2gvFldJzpv6mVarxz9l4XGk+HN1qpE/dt7XnBOWCvDLyc3jQ4fJNym4E4d1TaI2z9X3MhLsqKO8XBK59720=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057455; c=relaxed/simple;
	bh=2fut+Rt7mYuKdCcEnekd9YZi3WTIKF++PCSA68FNkG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1Pvx2pehzwUyMnq6Sj2IqphDlfGs1qCN8iIxkCQXGJq1VK/07I2p2a1ntL1tpcDkc0dwsftBh2mBfP1gnPVcs9wFa9JZnz6RUlC7S4xIqsly77OJ8vMX9VbTDOXciQhLQ/uKENOb1lBzherV3Fqrm4+gQhUUlGSUfG862ysflo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baSruozV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baSruozV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784057454; x=1815593454;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2fut+Rt7mYuKdCcEnekd9YZi3WTIKF++PCSA68FNkG0=;
  b=baSruozVslOkHBBojJE60+P9GB2Bem/ySM4/1kb/v1mxNuy3G40Wx54Y
   swMTxVyaHX0Aqf4z8Z+pbc3V8EDOVXensj/Uqu8MqXkW7BSEN4UbFGEbW
   3Lfapsn6eptgEU/PKmnFN+L5SRfe4a3L/+j/NBu6d6PfFXJ7O/KBZmnyn
   z84FPelqlBoKS0SQDKALF2fHS9Sc0mxvkMLrv9Ikk7YGdhYVSAmi/j/IA
   lfv2TW6FWAhth53tHZCbovBAx873KJncokxhq3g+Md0hxzYoPdG3beVzr
   BpVpaO/9wd0rOg/CC2T9dqNv571Fcbu9QsxHShXYZZG0D2sVTJ/M9JzqG
   Q==;
X-CSE-ConnectionGUID: qFtnA+WtRty455PK1TZM1w==
X-CSE-MsgGUID: NqMzqvZCQJeJ+PBwfXxHzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83811931"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="83811931"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:30:53 -0700
X-CSE-ConnectionGUID: tW/BSZW2S6u22pufn5w7uA==
X-CSE-MsgGUID: AaiNm+SeTGqLhI/XxgnMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279231854"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:30:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 12:30:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 12:30:52 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 12:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxp8jzCvh1tPI0d9P0D/kGHGTgrlddZ8dW9tc37LDH4l3lrNdObPjRNo1F3FDfDVHGmyCecpq8afrseYmBW8kEcpubymx4sUIimG46LL9ZMUp9iYcD0i0TjcaNmmLxSOyDnHX5ua2HjOvuCwzNzMLOXEe8y8gQYKKi345rGKSWv1jEcl15j5YvQ5/tuFmQaVGHHFddXux0OlyWqAMSRNPJCcLKPnzQwC/rUnllz+c/Aa39/F7wDx2DqZIMgfnt5Tfme3t5Rw895tzH2XxJbGPQu0tP8x21W0ioeN87vjIhXgq96S/HOMeFGR1OFI6uttfJrGVJ06BIqoZXbQhPG95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRl8923VylI4RxF7PVVNo3ZkSz1ZybUEbmAxS1NeKlc=;
 b=ZO6dpkdy+zMHi2KF8bkNa0pzUxsTfPPzPUKtGaGZJDGulhb2Byc6SR80auVPiOJjzbo99OkuoankTe5VOarUO8BiWwAzyEZQiRQ0HIulQk1X8H3X+IKuaeckmz1S3obC+jzXQgL81T5lSDFeWSeJzw/5UZh9UVp2uqa4BLjO1iD675PV/QG8Qc1No4entmWdGtYVBGa6+jAF8lwykD6afQbNOFCu20Ckzongxhx7XACI827xQpnPf7xmTSMVdmdgIgOKE0SfupQmzMKsy2GSuWw06j5CbBEgWPqcf8QO18o6yzW/8tpB60Df7zVoewqu7NsT8mwYwgOjUMKMlR0Y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 19:30:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 19:30:47 +0000
Date: Tue, 14 Jul 2026 12:30:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kobak@nvidia.com>,
	<kaihengf@nvidia.com>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cxl/features: Reject Set Features output buffer
 smaller than the header
Message-ID: <alaOY5oJP_2LGmdu@aschofie-mobl2.lan>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-3-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260626104102.53892-3-icheng@nvidia.com>
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7abc17-b1d0-4cb1-6bf6-08dee1de67e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: KruMD3qWBCVUvzUfkoPxnFEmM80SFVDkKRcGMSQguFZkt+AVOu43pBFfNYn2twZAUwsSnA9vl4kRtBzJ7qdeOZfUSebhyzFU1U3BWAbeZixvMnd5q45pa321OjLwAW5OfC3GUH6loWajF8VogRUsWugjJqyrlwtUcs44oja+uOs1HbiFlbZY+5HZONZx79J5w4aKrBUSGOhy1i7Rc9DpzwZmLWDFjxA10xTUFcvS1qDRoanXgyq4DG5miWaXFn7E96FAAnayAqlkusWyukGH04XpfrPtRCgiv/rObbpRwhGb4VBZ/vtObnJrX6tH6nozg1nnYPR8fO2KU5L0xKdYU24KPbZCbCOFAUIpAxlFK67L3fEMkfdmk9sgX4rxMnNJF+DRNoicyn+qDC3N9uBghJl/zDMVzx3vPXVZpGGhXWKL35R68enDLyRjhkPIHCvLET3Y87bOUe+zO7W8agmsPbJs1xK3+4nt6r1MYmykkXP26xfEHWTQ2VurPuB7i/LOQSjmPWMFIFWHGHdYpKLpzAX+lQ3fSoMfbkL+AEn4i5AGYLaX/8I1BzECcW/S8Ww8enLXaUhLZ658p+00O+wG+sJP8u3Liy5XnC5G2sa8/IW14+1Wpa2K/QrZYqDDZZT7m3uDWG5rDV9m5ZQ94QWOqNSlvDiygFXF7lW2M0NGCmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axToKOi5cwRdF21Z1Mqk8QHUfdKC6kf3Ma/roroD8wql54Ogv8SPDGJp89iz?=
 =?us-ascii?Q?g4XgxqPLeJWcIowgNwILR0uZsvpSub354TtGA2bp6UJxHOvAzV/0KgwIXxBw?=
 =?us-ascii?Q?xmicC0rcnqRvFkeROUAO0g1T846brXccrzKbN412pdUat69fkSEKXi1Yhjsj?=
 =?us-ascii?Q?chmx5/6amhDD0dag+WjK6noM/MlWajCgtY9DIgMjuSvOuaw46SKwGBPH+9HU?=
 =?us-ascii?Q?ZKASSOmWY+r3Sqx0wCxXwLXHcCghVq2LbxrydNHKrgQ1TOhPZ1c/PhFI4j+m?=
 =?us-ascii?Q?59SZxzySFztS0oxQzzpVJ4MKolZxHSTYqGGHkzCUITfLQSqjPRMdssrf/u78?=
 =?us-ascii?Q?uh0BcXj4pLItRZtx2TmarR+R5LOLeAQ3MDfZsYESq3zhXVBf4n0eW1ZLUQWg?=
 =?us-ascii?Q?pE8hfFOUgcxTOBnRRh8cshCzDPCZ139fb3bA1gPAmO1oJJ0pANqqCMB+Mjv7?=
 =?us-ascii?Q?8gOzISHMfu1Hkt642rsxD9yNZCjH6pc38osFRh+Hzz+6hg70PNtB1Rp45Ri3?=
 =?us-ascii?Q?zLgm3QzV4ny8tLHN+eUjTFiMrDA5q30FIm4/uCB0gmcwZ1GRfF7fjG/J9HAB?=
 =?us-ascii?Q?6vdPapf6d9hwASYFikgEEobCIvER3vfiJGJqn+GVEVtZYSGID47NCjDxQh5j?=
 =?us-ascii?Q?hlvfOE1p5/3BonxdVEsJ5Rrt7yFxKucucRJLeNlYVuIH2jPtBOkW8XKtTaEJ?=
 =?us-ascii?Q?S1LEbjC3EsleTcmXKX5Nwk7tY2CZzd1uk6xbPMA/KzWqS0kJPiL/MmzBT71R?=
 =?us-ascii?Q?49szqRIq8607Beh9FbcI3LlmaCYFPi1z1xssJV19Td5Rq6YOnpIBUuoLfFaO?=
 =?us-ascii?Q?25UDEdYrHQSXhFAtzMYNmqnD1Y3JLPiZbEo2PNc+5NCx9ot2Mra1AMLov8Zq?=
 =?us-ascii?Q?qaMqXYxS0SdK8ueRtuZhQEY2vHPR4nWAa7qhk0fvW32WHKe4D+LikJac1Apt?=
 =?us-ascii?Q?pkAvYc/VYVuwrW+zmYd07YJYDgEBS+0MZEa8rw3vS/khVyZTY9YuXZtCcy0H?=
 =?us-ascii?Q?hxGeRDRED7eFL9fcOHnuf2LHuS8B/nGX3xIB5XpLIVIcRvtUch63zl5ZxW1e?=
 =?us-ascii?Q?4rg9kaXom9nI1m72cBvviNEcutpu40Phi+HV5AU3VOc2l23PmQ4DMEh/KDr4?=
 =?us-ascii?Q?LVBZcmbhu5zW9yd4n4NMjKlwUy86Eu0B4yEkCkLKtor6ITmHtdbC5YO3THUh?=
 =?us-ascii?Q?oSQWBFYPIz8SU7vl4nlzAMEIRnsH/7MOHN2jVworU6e3ZEtzbWAKjA/eV0T1?=
 =?us-ascii?Q?ViWGeTJPp3qJsuD3GJiBnzC2Uq4Oj3AZV/q3aApgpmylOB8T/QNb7n3tQqxs?=
 =?us-ascii?Q?lHVIgfuMuUwWg/R2qDoxSpTkQ/hFpvZikYtx7cDEi78e82G6iJ9DltDZpKdQ?=
 =?us-ascii?Q?YKPX9P8+j52acN5CC+7VynFVDidXPWLBBabARIfpHXGsVMhu7vUmwPJApkwz?=
 =?us-ascii?Q?NTHqiAtZpHmnCuO2DgfxzDMxJOTnIdm1mdocJtTfx6KLobFyMELvAk6Axhin?=
 =?us-ascii?Q?Cfe14eWLtqh8O92+utlfq2WDzaL2eoU3nWFkNPX5ICFbkBVOX5UW+uRk5cR+?=
 =?us-ascii?Q?6Om/We1u84NQ8uzzFI526GPbhnyfQokVBjLKwwWpmX8i0hAFDg054NI2CDmS?=
 =?us-ascii?Q?ITmdhPwi5+HkMVX6s6PKFENhumHbOtFQlrOOsXH4GYfzHvlTRNQLsVaiY0iR?=
 =?us-ascii?Q?0Eu/f/gasv/iko9weWLWpVYQ532pG3ubtdjynm7Y5MrWIBTTe0XzqCPu/zLj?=
 =?us-ascii?Q?HAMfHxPnIoa+MBnNV8Fx7Y1TIT+mRd8=3D?=
X-Exchange-RoutingPolicyChecked: gAyPlSDBE0eKoTgvIb5U+1qUVSPmGyLAxdJJNtqupTqQN4463t6lZHe6/VK/x6J9HXGZ1nlR/jzJZDKVuPW4h3oDjcY+NQrMJ9bZScGwZuELUEJi2wBnJaxegN5c9anlhxlngwgUA3sQ3B9l7C71YW/Ks/RaM6FQY6KdWMDXq5BptwjEfifWxaknOWZ5niD6RzIIGhLVLYEOdE+B9ceTFk+C1+BJUzbiTJgypZqBWMS5iz05kuIezgc79daejLbR9uBFWYqt/CD6m3A0It85BWL9LnXsTS1OtVyhWZHzGTrebeueS1v16cgMLkpb57+aK4SYT93hzqlW2bH+gneJfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7abc17-b1d0-4cb1-6bf6-08dee1de67e0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 19:30:47.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8TTcp/ochRt+yhE1UXNHMbeCC5l1sQI2em6E4exvpClKCOCS1GDQvdsten9+DL9NvzcR+Ecy22ZzlbT+uPH9n81F/mZQUpOpq5XEST16Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
X-OriginatorOrg: intel.com

On Fri, Jun 26, 2026 at 06:41:01PM +0800, Richard Cheng wrote:
> cxlctl_set_feature() sizes its output buffer from the user's
> fwctl_rpc.out_len but never checks it is large enough to hold even the
> fwctl_rpc_cxl_out header. With out_len == 0 , kvzalloc() returns
> ZERO_SIZE_PTR, which passes the !rpc_out check, the subsequent
> rpc_out->size = 0 then writes through the poison pointer.
> 
> Reject requests whose output buffer can't hold the response header,
> before allocating. The Set Feature reply carries no payload, so the
> header is all that is required.

See my message on the ndctl PATCH wrt adding a test case for this one.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

