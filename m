Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793853701;
	b=D8u9nINj+7g5MmTS1mcDrIjgPBk8oyizpXMMfXQroY5QvzUWpV5vxHn4TU/jQPLVzErh
	 xyXtxydRlodgbmEQjXrt7SWV+XzqAKTVAUKyedbTOVbd9//xgKEEaBa8ZyyGtH5Y94E9i
	 DlzuiHwkNy42bv0XIpf+eCMnyHScLClVL6OCITfFiOW6fzZG2Qg/9wJDsGGqFcOKoGqZI
	 9dQna4FeA9F/r223HVpkHhw36ukSa6BZdxYZKFVvGGHUDL1767pNGjmSWKWmnL1HfZhUy
	 /sKmtBUfppnl80xHKDlncqy/bPhqk0c9uq/2wQs7Ye9rBJpePfM4Wz4+wyYC7TfCdTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853701;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=b2nXyq4nTCDfJ+v3kXNemI+DWvxJW/uLhs/b0pyw4F4=;
	b=GWuhsBdoTU7VWHgcYUiwJUo1uJKcm5E7xnrqquBsj/Tg/0H6myc96HFGSELnaNuNNBiX
	 4iUSmeSIuccWmC6QxuWyR2Etpv9JaJfCLVIeSKc8L+Hz0wchET0Cc/zZ1297CgrnLArYH
	 0jSoqd5UKZMZdcWVA52wowGjST23pq6mdoAXwsQYfaESFhsUcGPGKoSivWNTF68cPc3e3
	 7s7mBLaBRwcVEwdaWf8xFAx24thgPNdUArpVKLwBrnprDsfeI548J5P4G2Md/9W/qBaBt
	 uK+bXoE1XEaNYjFANtray5byXzzzpwTaQOE8loDmCcsvrAAxwOPoceFp2xlBw96wsnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dgBA4ucs;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FC606A32D;
	Thu,  5 Nov 2026 04:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 068FC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dgBA4ucs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793853700; x=1825389700;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DqVgPY/UYuz31QKUqjtxemaCxZ0sNUFg6u7GigRogyg=;
  b=dgBA4ucsQquLDGnnEymmK0lbjUe7/GuMOS3owllVGOBaStOxIM8KUAKJ
   TM4XdV2T1ghTXkMbtXRcQG6Gd8mD3RitAiRC86Av/FsRZcv2Al8WNYW9E
   /r+sUYct5aCv1sCcPlQfhCs2z6xAbOWLE9tMG84a3++dJx1/5+RSA/v5K
   O10FkyOwOIrHuGMzhXd8ndsXFM/mmUkQaBfisGHBhyKGsam/eJFK404xn
   e9KMjLobeJRazfpH9jzmv52iqYoFgR+tqIRk3eHTBGM4cIqn70VKIfqea
   4MBLrE+fbi9k9oQZmvaOu3Ve9P1caWwedQeWWM/99Bo0lluiW1Q0teZNS
   g==;
X-CSE-ConnectionGUID: pleAUBscQCqNpQuU3V6Ukw==
X-CSE-MsgGUID: yToohNZbRPGxpYlGI3Plvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2721597"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2721597"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 20:41:40 -0800
X-CSE-ConnectionGUID: +Gk+Qm+YQFKNY7dIujPpJQ==
X-CSE-MsgGUID: PIfpO2r3SpKlcgONCWuM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8670886"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 20:41:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 20:41:38 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 20:41:38 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 20:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD5vaMhbJVRH0glmw5Vn9p/3bzc30NXPy8Vzsl6AA9zqNmLH2Ozh0vq9O3wR4+NYipqgjxVcny3IIb2CBJ3Ah3cY8WS0gez39bm/UoWxE0KnbdkDOyehNPTN6AP2dqzMmcaLqVBOwU2sAixodKYSsppX56w9HQQHwVLj3YUdpkvjg0A66S8h4tgPZ2zX9eWcsawMGjImPE5Vtxys9RQh3vCM6t5b/f48AWfckNudDAM6HIerWWas5kxT78uykQHMvPVzSQ1rBy5s3CfZPSMdEJlqGg+PC/ToK+ejUX+Me0+0Ll36BlJ09gLn37szzc+qRVkwqF2DuIMTg6DFwxiztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2nXyq4nTCDfJ+v3kXNemI+DWvxJW/uLhs/b0pyw4F4=;
 b=XGZEUIUfvSz2XZcKMViZJoDjjBfTmc5O9DYqz5RVIZdVKOpIivPWCUQQQU1VIHtYIYbfTRNZYVLWp2Cw6+l+MEc+2cHi5sQre/LKOdIY3/UhX3Yx/OlnRCI+P/KsK5GbwlvYLSTtBNrFbMaswahQxyP3OZjzN5noo1EZ/QwPgk4hkjA1BjrtL8IyfQz8ZXFzNNPUkGc68uZvFoL7lYLztTlbXCOuxzFZw/m66/Bm7NKkNSWaZ7FsxNgKdcqEfdcCWqLcJxxept0oQ4bXBp8NwI2FrYuMktyxLH28AQzuw4GYaGYmIewZGgifqIVWLOxqkrCbE2urNbnpA1k98k5iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH4PR11MB222363.namprd11.prod.outlook.com (2603:10b6:610:508::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:41:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:41:35 +0000
Date: Wed, 4 Nov 2026 20:41:26 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <iweiny@kernel.org>,
	<icheng@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/mbox: Use mapped errno to determine command
 status
Message-ID: <auwI9iLC0NCRvp9R@aschofie-mobl2.lan>
References: <20261103024305.2333508-1-ming.li@zohomail.com>
 <20261103024305.2333508-2-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261103024305.2333508-2-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH4PR11MB222363:EE_
X-MS-Office365-Filtering-Correlation-Id: 127785f5-24e2-42e1-0d79-08df3af71253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|261021121427099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|261009223027099003|261021123027099003|56012099006|261022105027099003;
X-Microsoft-Antispam-Message-Info: VSRNytBmIjXF0T354GTwHV9u9zeMs2dmZlgU8IT9yKysBRC4lg2OTfsWB50XeWYW4GMSeKM2mYs/ttbNGyP4p0JsOAl5vMB16aIFNkDgF9OHo77A/MARJgYlReuvkEIMrYNtUNNHYQhNDLtOugsNBY1mMNYxtRsqlAl0slJr7fJmL9rwMOd8eUtv+g/nDX43smElxsFi7hsW80280j2PyLn3PxjIFZGHcQ/QrxwnU1WMPPLN0udGa78d1LP0eXe0nty2OAJpNjHUSY4tXas8oPyKE4x5JYhbthgimBv0eBY5+QHIUjoJbCV3vMU32IUiFVI0Zh1PqzBNPhzr0t4ACbobdUkuxeYIP8YsNFo5GhhdSTf/oQaZh4PBLkj8uw6ID/zhwwd6WEl70bHZeTwcYw05foKboSCgTIz31SVv6GzhODka99ZMNRE/HqRvZVMfz3db91D5Py4EtCpA0bLyX1x/uuMqDHD5K+suxiFH3U64tHiWHWIUdiLaNst0lOkuNqjLayILWucPqaPgkxbGRnnk6O+UqJtrXRDW7AHC2JOT0eCtoka6DX40d1idoP3taddgV/cHOpidXSJS6eJXZl2SIzj2GJC5j4HDZD7vYWlnQ8G/Ep8sAZnjlpMcZfiVhWGPWy+vZ0IVTpoWNFqVKKavg8tCB4B4D0fiuWMW008=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(261009223027099003)(261021123027099003)(56012099006)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MmX8AbSUvS4CDruAxs6AofxssDBaVJV25pkcmI9MgPXzU+jz+VZn9Npd6ar?=
 =?us-ascii?Q?QWxGWRenYhjF+nQC3909BdG2/ogsRHXaMfvkYnubvOJTIcqhQDnvD2RCes9P?=
 =?us-ascii?Q?ksig34tyBl9+7rtIQAL1f9vzntRJQQ9Q7bOys9xcvNCRgW6LOh5HL6FmSQdq?=
 =?us-ascii?Q?dBp6A143Jf8X7UFCGeCDCNWwe2Gd4+ZKLclYfcfLG5KzPjJ+EQSDko/pffSl?=
 =?us-ascii?Q?DNLObf9/1adPuZ95ooUOjgI9USQpNkR/D48FBz2C13ZC0Zpgm5AyvudZTEKv?=
 =?us-ascii?Q?6VU6/0+Y4HCJtqVBWFk9VC62UAHBDUJJwOukXRg5nzrHS7f0ntqcWRbpSdj2?=
 =?us-ascii?Q?ZXHYHpceS8D5DCwAg7yUpjux2rdIYlRiWYhsFqHBUVcLfbTlVH+8W6TBMD5O?=
 =?us-ascii?Q?wAgR+cVho5GBIbTS+buuy5a2BtL3gA/ng83qqVX/oRbIxsI7aTvJv5AEZ1eM?=
 =?us-ascii?Q?IB24rkGIgXSDLRITccMrtg7kzHLVCJyYG7RoV8WbHz8+EdxSXhIYg6piL/oL?=
 =?us-ascii?Q?YKleRswXZPoNHQ96ip+vcMVajR5xJ9J0EkETRzpwxZh8Cee/K5D0rxMw24rI?=
 =?us-ascii?Q?eNOVKi3hrmUMB5Vs7xZTzQI9syTwlcUMcl5w5wtPwrO5+rFY66ir7igGNiLJ?=
 =?us-ascii?Q?qCReuOqoeRZCbCHjHVMxuCjfQ0yrZcZAGcQsypBoVQFM2DlBzM+6HRIPfrYV?=
 =?us-ascii?Q?41i0C94tJrjv/PWXfDu0R6JCkMONzcbDIu11ROJMdH1K4NN0qgdLbub0xKnF?=
 =?us-ascii?Q?TWhQC28l/A4szOPSFBSU1WsN04tFXHcK5oZDKAXc9JXTvO8KwF9RsaLNpNaD?=
 =?us-ascii?Q?J/ZDsACBU7wA5wcUnuV4tqscbSBnRZno6Y6hAporM5TGo/KrkLvht1CBCf+v?=
 =?us-ascii?Q?J5Cf8xJnWurYyf4hxMcOP+OgSc5s5J+0EHWWOqv3aKq75QKIrid8z3IhEDax?=
 =?us-ascii?Q?w8DTiIDEP2BXx9WbeXgdbLmQzCaQSTArUCyyBBbig5rHKnV8SvyrNydRqDy4?=
 =?us-ascii?Q?gnaB8g4XtSYa5PdTlWnVtq9FsvSWnR+bft4vtHA+SQw5vmF5h3FG1hgZhePj?=
 =?us-ascii?Q?nCcomehgovetG9HY+77WBeIcnTa+BR1ejzl2elcVkGU95xXZSqu2ktddAxlD?=
 =?us-ascii?Q?H6Lq55MCVNXeUyVqFgI6lhqs6c/LU+MgIEQfBGzqRBBEEcD9SPZMoa6fX6+Z?=
 =?us-ascii?Q?itElUK1nIOmkOZGnH8Re/ysf9kpiWzpFFS2kypmVG6oSYa26DuVSQMv9PTTc?=
 =?us-ascii?Q?snv9dcDtKR8DJd8KbkZ0CQXzY82F9k7W32LzzbPdokJ4+y2r5xX3492kOyHR?=
 =?us-ascii?Q?qgXa5YssXCce6G1aAEnjDyDm+zSa8JM4dNbRcmbo0bxgDk1jpAUnPbxXXdKC?=
 =?us-ascii?Q?Dr7N4zCX/lIBSKJT+6CmGK0+//e+lrWRN+z3lIndQG5CL2d9pkLbBJFp1AHo?=
 =?us-ascii?Q?v614VPQchSXeWb8XO5GDFlX3HyF3Yt3egi7Fr4d0Y3fVxQhKSX/zPjFXC4eK?=
 =?us-ascii?Q?YYtGhKohBODWRbQemuNpqzW/5Mvg685agNmT9c4A2ouk4L+R1aZ3kBg+2/TV?=
 =?us-ascii?Q?f8faeaUc249+meAkeSLdxx+uZ3mrUg4/axsVthrNgKJ+kdEvCNLmtBV67xAE?=
 =?us-ascii?Q?T1/PsmBN9psS4ECmlrcjxnPRYOxWpTtlOVqGvV3D+T//mMCJ3sIWPEZ4wlv6?=
 =?us-ascii?Q?69Ev+VYtTGPhkPE0unYJkEkkl0g1j0CdpuMXXAWNbtSV24dK0RE5qPwoIpKv?=
 =?us-ascii?Q?tNTAQeM5G23le798Nobe30ZfBwPwztM=3D?=
X-Exchange-RoutingPolicyChecked: zhDnGPhZH8NX5XS+8IyTO16vSU9Z06WdbGuSiiLSUrm5VYOkKGj9woepg0N14QebCpKIjtN76tCtISc1rYLnO/PYh7HA09sncGacrYPTgSL5EN+zAwvzMMeXgOc+wbuJxwSwlIZwA0f1PnQEtmV2HazU7rI2LpsMwtSx5dNC88mbaAN2CNWhbK4Dr6f+sJsz1O3WOMWFJdkTZGHkRd+MIM6CyN0oBLp3/YDuw+l3W4160p+KFkw+Ik1+t6FlHt++/IBnpoO6U/Qgu4f59Ilao6qNcYmGFKGOx4zXPrNr3WJqBXG+f4qQaaRhyS243FOqY6WR6nrrRRGs1rp88aVwYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 127785f5-24e2-42e1-0d79-08df3af71253
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:41:35.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeXAa0I1ShqqQqUDAUEzgAwPeFkh+JocVDIV+hwz7Qtn6cNLCiqWTO9fkrm/EtCsTbQ/dnORmVuo5jkj+KdRoEsedLgqL9mapgXjGniCfTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB222363
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 10:43:05AM +0800, Li Ming wrote:
> cxl_mbox_cmd_rctable already maps all mailbox command return codes to
> errno values. Use the returned errno directly instead of checking
> mailbox return codes separately to determine whether a command succeeded
> or failed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> v2:
> - New patch.
> ---
>  drivers/cxl/core/mbox.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..bd91b03c4d21 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -270,9 +270,9 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> -	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
> -		return cxl_mbox_cmd_rc2errno(mbox_cmd);
> +	rc = cxl_mbox_cmd_rc2errno(mbox_cmd);
> +	if (rc)
> +		return rc;

Hi Ming,

The existing code really seemed to want BACKGROUND as a special case, so
I searched the history on this one,  Davidlohr and you discussed this in
2023 around sanitize[1] .

I do think it is confusing and if we can just follow the table codes,
that would be easier.

I'll let Davidlohr dig in on this one.

I read both these patches as cleanups but no bug to be fixed.


[1] https://lore.kernel.org/linux-cxl/mw5bsc5u72fdrgo7qovj6u2npg2asftzp3jeprwtmnvbvg7vet@fayzcxpurjl6/

-- Alison





>  
>  	if (!out_size)
>  		return 0;
> -- 
> 2.43.0
> 
