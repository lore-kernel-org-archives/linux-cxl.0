Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26E2836F
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771635831; cv=fail; b=oPjzhuU4jiGZU0pESJXu3DUDA65gAPB0lqzam7RqTeOOHwsq/K3KQPbEapx585F6W6PhDFBBkALmirZWcgpSUqCkL1eHQ9W+kJfPSuRGsJdTlQOWdV6Ys1yhK3JMRsyerHkTTU37COF5xOdka1SczmKpkMLVxNAmbVWsfHscujQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771635831; c=relaxed/simple;
	bh=zcJY+bKMlD490Nk0dcisxvbVXDbkLHmhCsN8RMSqkBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMydybqZWj62sJrwQRx+VtNF+YzeKNFOulTS7pR/nzEAAdVM/SzIe98Che1Zj+zPWATT39bg64zFbe15uWeFWFJ1/wlkQAbj9KEqzsV6UcC+0KU6fXVIIu9KNJls00P4Lk6jILy8hkoQcrDp4pGcwQbh9cdohlqMYYzyjJsYBeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrZHCOvZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrZHCOvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771635830; x=1803171830;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zcJY+bKMlD490Nk0dcisxvbVXDbkLHmhCsN8RMSqkBA=;
  b=LrZHCOvZFXzudbh/VBmffHg5/QKlo3msQHxYXcqMd1zabqVLUNOADHqw
   bq16ygHZBCTC2aaIHqWMj9PxLQ6g/P+6uYzFiMPKhqvmFN8b7JmiQqoj/
   Eovbxwk/YAron+OqC+QvjuiObh7e08mc/sCOSdaGZy/byY82f83F8x+iG
   u2cWbgvNwxEyAVkoYJ4t62828R9SsYKgCGoH2z/rkqjTRzVUqNfjSXPeD
   Uw5MJyfPZ3zXMPFklBtiagPjkU6j5QwQf0Z7YNBYRC7Z6w3qSV+7AeXS4
   h/mClJ+OJLpGYX4kyj8wdOTY980ZuDs7Lum8kUqZZEmK9YoDgsArNUNek
   g==;
X-CSE-ConnectionGUID: SkEShV+vTcCiNOuDx0yU0A==
X-CSE-MsgGUID: I0Mybo9NSjqNbkqfgppZYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="90314763"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="90314763"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 17:03:49 -0800
X-CSE-ConnectionGUID: qBe2Stl4TTqPsY9Bg6kY0A==
X-CSE-MsgGUID: fqvRdwHjTGGPGnSZFMF66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214007650"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 17:03:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 17:03:48 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 17:03:48 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 17:03:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3qTMnAGVxto6r/ptbK/D6TCveZ5wICXxNbC6HbpBjPnbtp5Wudq+1M/qHfkQEoNg24ybjhj+TIT5z77BFdpkMbm6XdaJqWqjKb+mzWPEoVYfE5iTZx7o/fvgcT2UpTWiDNFVZ+N0cyGuAW1bxeTunJ8pQ4Qe+3Y+yNdCoBb/bInGWOJFZyFekwQZCJdSgkhODvlhagBl5BnfTBX18oMWWMoXK7DaF/vQg8gBhDRS6WPl45y4EDdTVRsA1f30se6Y0JHOve2BkK36uSlbcSAj3ESJ5GhB42nh1a7893anJ2AiAPHqn9uTGAqSLDelYsXDEg69etpGi7ESOcKMLmnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2OijvhzcY/cUiqZBfImtaoGT94jrX4NcN9DVoiWsSI=;
 b=LIB2yeUV4+uTVQlIC3DMMszF0gYfTWOyqEhsgT+3RUQWE1WKF2+Q/wSE8Ux1TuvGGOHL3ywb9MahG1qgeJVkdmEDUHTRK0bPVNdP7zwbdJAjU1WNyS+KjHQ5Jcbl7+V242eXaTtjE6nwYoJ/uAo9ElIehH3/6euNBUJiHl99tLwMFjEc/AkGV9K0e/5H08Q7vZh8VcOKeYcZ8h2C9p9mxIwa8w/3cZFqc0DDlOM8vGx07l3mdnTofakq5W659T1FjI5DZxMgMv+evd/mW14PBaApLTvKtUUf6e6Yz+lzbbioQD4bQl2+8kLRYjbS4c+efuJWgVbeFn4EFTDh/NUDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by IA0PR11MB7936.namprd11.prod.outlook.com
 (2603:10b6:208:3dd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sat, 21 Feb
 2026 01:03:46 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::1879:7c61:49b4:b2b3]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::1879:7c61:49b4:b2b3%3]) with mapi id 15.20.9632.010; Sat, 21 Feb 2026
 01:03:42 +0000
Date: Fri, 20 Feb 2026 17:03:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/2] cxl: Fix nvdimm_bus race for nvdimm_bridge
Message-ID: <aZkEayARHFqMe63d@aschofie-mobl2.lan>
References: <20260205001633.1813643-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205001633.1813643-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|IA0PR11MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 30dc57bf-6cc2-4f0e-be0f-08de70e50e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GRLQNLFkTbiUoupqWdqFlidpozDnvO9eR94AmhxtDSjMtARSAeAkhKRFLQAb?=
 =?us-ascii?Q?jkVu+5mtWP10gHnjIFP3fBqYRfNpH96rmrQxm6bwQ+P5GD5051CJ1/yQI/mE?=
 =?us-ascii?Q?GUzMLgrn9Im2h2/myQf6S/4N6ATboJarOepHPHdMmmv7GtzJ7Hr/Y3lU8Zbz?=
 =?us-ascii?Q?khi7w3DBxIgmANIfvCNg8/pBbxwmnPh5VnZeokk7bpugQUa/Yim/1RdplxPw?=
 =?us-ascii?Q?DCa5jQTcJ/qcYJ2o0QV2HUiSv2HOfOsaltAzufh4FDp6wFf1e3VqcmQ3r4Hr?=
 =?us-ascii?Q?HTY6trZFwLeg/wqT5wzcJX722s4d8Er7fc9j60KhYSdGZeRns4ax5BkjLSh8?=
 =?us-ascii?Q?9jHbh5ZhSbNt+LY2slA70b/jVwM/9/OMFpcR4GivJmIw+lXf69m69wIMMN9J?=
 =?us-ascii?Q?YnTo/FDwlnn5hLXmW3B1oyRGV3Sxl4xmOAzRsWBXMJ2JuDms6H3noURjxhjV?=
 =?us-ascii?Q?HdHTn3gRczYnjRChLOX6yFdkgFPJRwTnTSyYIujX+W1ZcWIWEvW+hiFCh5Ra?=
 =?us-ascii?Q?2yZpbzbPlR7eFDHO5pSwGqCbD63rdPSRrtDwv8yPLStqQ8DgyDoPCQs1oDOg?=
 =?us-ascii?Q?qJccwoHq1ztdh4NYMnABicfGQqxzBHlfc7aiioIIxK64ZwOADGJYxB7sWNJf?=
 =?us-ascii?Q?o//+9pIzL2J2MDfBiE8Z3P4xj5Zt3z8aJym9xGdoioSIUhsYsd2ZPyvFBZ0b?=
 =?us-ascii?Q?Fe1GHIJKFcIyrj6PvFVwYSwL7lvL7Mu/55waMbEqDGrN4taKbJGZeYv9SHF1?=
 =?us-ascii?Q?+Lab665PEHOOiDeLrLUzCm4duhWu8mqKBORjdbpiv5NKQ73KWOhvzLJp6zN8?=
 =?us-ascii?Q?MTqbvhZvwQ4V1L62SEe94twgxGgsq7ND10Qq0vxu90g9KhC9yRPgLEs76EzD?=
 =?us-ascii?Q?gjg/TM8i00KMZ3PlzcrtT6pxOuT/PCcJ0Oy/TbJ6VGb57qNJy/Fg1a5gTaXJ?=
 =?us-ascii?Q?3v8X0PcSfcz5ec360GLhuXzd3kmO0ZkxCFfF9JzfODKW9wWxip4fG1n+bdbN?=
 =?us-ascii?Q?/RHV0uGny0shIvHQHwHKTPo/b/1eMGsvN/QNPRzrjpqyXLtn+1DYwPGgJ3+q?=
 =?us-ascii?Q?iOtNKy3naPatiZUv8TDRajaPUzpR47Zjns+JJ9dSBrSIwYkWjQeOtVxm9l38?=
 =?us-ascii?Q?0Y4GX8UrKdo4W+4TOzD5ufK5Nnf4I4vAcCKLxHb1QogiDunN1SGtqSQKhBk3?=
 =?us-ascii?Q?2C9lwgOYt8Up/uq4hlP9mXKBkC+ruWKH0IrW8dUUbjFwYxdzJtsHnrA0I2/c?=
 =?us-ascii?Q?9gTUSZb1OChODHEoGDneX4ZrIQvj3OXFd6Wjt94grF4VPNX/2YRDWDPFvSPx?=
 =?us-ascii?Q?ZIqPHZg31IpLXHzQHOGKPbt30O9+wGNyURYe1f6Nq7BAaHKy8Dk1VPeifItB?=
 =?us-ascii?Q?rqnTv0oH7EU2z3WvYbpIdmx85tSKv+5srd7C/n65d9e6EDoy81nNVmJhIGOh?=
 =?us-ascii?Q?hbDGq2GwAkr0Dulj8+6yA6RsQ8ZHvIXsLU2kj5J2wfK/eRnU8ssByDZMQTJv?=
 =?us-ascii?Q?sjbkhgufsZhYMhEwDtUnao7Jy8TBDbKdWbp//t+SyTj5EJNwsTRyZhZYEHFl?=
 =?us-ascii?Q?tUo5058GuSD6QDIraVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQRrOx/Ql+WMcCha9mmSKxKP0qrFgl2XdmGbec1NPMVDOC80VfFT463YJpth?=
 =?us-ascii?Q?aCyDarR1rLf2ELHq+KHYSwSGOquddh96O6GbJWV22CTx+jU0bPNZ3oyzeI5L?=
 =?us-ascii?Q?S8BqW3jJIsrHjDL+ce79ul4h0vBGqgwByg+AGraHGbOmFjW8Ztx2TcCT4U7b?=
 =?us-ascii?Q?XhNFkeqlIxbwdgSsHjg157RJfSJrnIyvWMJyLx+sxXnwyyQo4XbaE3IcIYqA?=
 =?us-ascii?Q?xPuLLOG2ZWCyYLhblA5AfILEM6WvbAh9x5JCbGcMhoxilFh8otFU/Ry11RBT?=
 =?us-ascii?Q?INBQfLLL9wtqcPizmLhrOsyYCwHLp5e5PtF2yvMivKmZi1fqzcCfOkdbqJPx?=
 =?us-ascii?Q?XgYEiTyBoNZF+ftrun5LsBXb8aQSee62ovlKZ3+jr7ecezwLFKrrCGuN6zLm?=
 =?us-ascii?Q?6iS0oOF69YPjfxjXiXrsUK7QOtRJH1CrRB4qRwOTPksmfX8Gfq9dPxEEI90H?=
 =?us-ascii?Q?zx1FJlB0kzbtHzvxACx/mX6icAL0iuB0T46xtAM22iQ4bOfi0DF65Xdf+BDd?=
 =?us-ascii?Q?7z7UaHQTEEKGeJPr3GSJCKFgMpvWC0GTCHVye1mbCMlKgfz2LroiElNsTfUu?=
 =?us-ascii?Q?T1XGZ/sH+/5QdzMHwadmmCnROZcYMJer7FrM5cdJbv02VydW0AZhN221Yqfw?=
 =?us-ascii?Q?yvrTxd4U0ni3vVOEhCF8muzSu8jqC5RxtvKnO002TIbm6YqLwi6DZikw2E3w?=
 =?us-ascii?Q?Xs0hUWaSBf7j30Ti7vasYDQr1Kr7ks93RDjJl8G5ZzAbzIWP2+P7ctCJyO/6?=
 =?us-ascii?Q?NOYwteWQFUWDO+lK/NXN3c2s3CND6+zfsDKvUv9OOa5ejJ8XaqQ/1OcpxmU9?=
 =?us-ascii?Q?ZVPI5vKJibmlY+xntQ7lH+EOxkdCIxXxPa5Che4NFd6lVmuZT+MfLcrMrmvZ?=
 =?us-ascii?Q?CfaxSinxxcBamMAZPIAqtUB1KMr13lX8HIElBDpZRpLLHlBZwNYkjiaOcswc?=
 =?us-ascii?Q?Y52C62gqMQjKrpJ2ddD0g+B2qc+nZwoGAHihegOQnKc47s+NpbG9E2Eel+eg?=
 =?us-ascii?Q?6ysGP3FdkbneIzSIq2ee8rJACQCZ6zI2JJCmyTSpPFXHxOM35MpVTIXxVWVt?=
 =?us-ascii?Q?ZCFcBqhAwv0V7wDexd8h4xSx/RIf+aEQWZpJzaI/YU9Z2GI7Dh5aY7wj206s?=
 =?us-ascii?Q?b2p33abStcW1kwtQN+0IPlEOBf72pecSz6BtlBQkh2Nwi7pcQP2i6LWcb+rN?=
 =?us-ascii?Q?SB1l3boChrjf3mTZ7R1IqNa9l9wg/8YlB2HJIhstBGlsgoyWs4FPqXlAuRS1?=
 =?us-ascii?Q?8L7d/LD3EIzl/dhutVKaGMqa4ziio3efpZYnIYVRDdhPpEDSBVn589a54dJe?=
 =?us-ascii?Q?9yLJ4z0bc2yRGTkDaE6o9QJjQbRs1TCOn/2QcAeGOBB6z7MPbdvFEj8pIcBT?=
 =?us-ascii?Q?YLzfpg/Qx092Y1vIDZOZWvc2ZYB3rdzvA5GJB5zOFHLJ4pF0SGWw+w1Nt72p?=
 =?us-ascii?Q?kOiFpwdrPU18I4PTiKlmqDCts+uvQfOiEv60astyt+G/Z9JKfa2J/uCq0m4x?=
 =?us-ascii?Q?YJlY+p8Y2fsVOMaInSZXoczFN327Xt9dgaUrVGCezY0scypzedlIMN1Jj56P?=
 =?us-ascii?Q?aH0ekHMPZMYwWSiQC3x2VdkEYIc1Ub+JqYYe9++PIjyeogYvSqLE0gpGHfAB?=
 =?us-ascii?Q?5I5pnLz/4nUzah4WUeAmPY1DJ+cZB7WdyKQMsGmFtv7QabfLcMqx1SgyM+Id?=
 =?us-ascii?Q?/dUSCCCdJdrrhOzD5RpCvYdP7T7zxJ8fDeyYeSMknRr1bo/QVAl45TaoSVJv?=
 =?us-ascii?Q?Sg208R55UFnvD0mPGat5oAul4wes9Qw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dc57bf-6cc2-4f0e-be0f-08de70e50e4d
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 01:03:42.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhQetHnc9SEcI0x7aJ5/JUjoTu3Aqanx19gYRCySyGT4+wso5U4YmJ41UoT8nhZoPtQxC+2461MFKiQ9ADPMzMbWjkblBK5uBkU9mDGNt6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936
X-OriginatorOrg: intel.com

On Wed, Feb 04, 2026 at 05:16:31PM -0700, Dave Jiang wrote:
> A small series to address a race for nvdimm_bus object when using the
> nvdimm_bridge object.
> 
Hi Dave,

Sorry for the delay tagging. I was hoping to find a crisp
reproducer to add to the commit log, but nothing nice enough
for a unit test, yet!

For the series:
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com?


> 
> Dave Jiang (2):
>   cxl/test: Removal of nvdimm_bus_register() wrapper in cxl_test
>   cxl: Fix race of nvdimm_bus for the nvdimm_bridge object
> 
>  drivers/cxl/core/pmem.c       | 236 +++++++++++++++++++++++++++++++---
>  drivers/cxl/pmem.c            | 199 +---------------------------
>  include/linux/libnvdimm.h     |   2 +-
>  tools/testing/cxl/Kbuild      |   1 -
>  tools/testing/cxl/test/mock.c |  15 ---
>  5 files changed, 221 insertions(+), 232 deletions(-)
> 
> 
> base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
> -- 
> 2.52.0
> 
