Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70645225
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxZ9y+T9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704429041; x=1735965041;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jT7n3FHbTgpLJMTfvgUMC2Vfwc80lJGI+YR8UPwF0sI=;
  b=SxZ9y+T9Wz/xG5IQiuJRcR02g8NgwYOHIMdFCGDDULQLnSjDLnh3hSuf
   tV7ZYd77oWR0xHR1dLdT5/oG/3qJ0lfFLT9KiMMmbuSX4f6hsI0rXBAyf
   93hXMll/l7J9EaRcRwnjoNFmquzhvS4BDcDWPu1z1fl3Z5LoIvqCPIgME
   IZswtxsFLe846NiGn8C7a8p3ckav/hPPLAkAkVQd8UXDlSWY+hQ4ozkEh
   As0zq5OB0DEUElGMncSbjQ+M1sb9bB+EZS7tn7oPTfPnt7btzKmkYcT9Y
   yXbLqy/koiE2J10BtsYEZo2pKaNcNIzpxzik8bIBbAx6tt8e32z6J5YlT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="377582297"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="377582297"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 20:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773746788"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="773746788"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 20:30:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 20:30:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 20:30:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 20:30:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 20:30:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIWVcFsz3qF1bei5SSPiFclHdeFRE0EdQgXlJZyugGd+U/wUq6drmw1KRaSAEYppcKLFtF6dycl+3uYGp0mhdLCGCzd3Fwd8zd1+t30YUy36jvRoMiz207lvgPCrP+Tw1qkH//d06WJCQpLxaQm/nx+BPFihTNk95HRVCyBt0Vcdro29W3Z2BAD0YfLN6lmkYow/jZKuu+7iUVbXSwCXnano0/r567JOSNPFTpl715CEJSLkS2I3a68njUPeI1Z+V3xWU82R74sTp/F1dvXEx/DrG0rPF2gIBqUPsIaNCoeDheE1nUHNfZPKftAiFIWvrW9OHypPRLIGeCVwcvPYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT7n3FHbTgpLJMTfvgUMC2Vfwc80lJGI+YR8UPwF0sI=;
 b=KwrEe0a+9vT2pz3DCclv9H7ZGfYu/6d3GWrdVdXmoUCWDqifqlUDMhUioGYGu/mHCSf9K52CzMXFQ0CSlOUmvLW7jlzhoUXeX+3V7tOIhwh+uiqBDdVZvE4Sgm6Z0Syyh0/n6Y4tWGSbbx/WT0XbsY1oTjm4+aQ+oGNKUht48J3T75nHEdEaj1BU0v1uAPmdBf4d+HSbnivZHVGXGOWEVanSrBrKy7x7oLfaYiFuxgzlTKeLQOBIPn8vLJrG+aAeyth3ITMsH2VgMcNQK/RDTwc7/qhMxCTANNSCF8z9iJvPZ0DrRjZCpr+pDIhgcheoeSk1X1UdLIpe69bRtaYz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 04:30:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 04:30:27 +0000
Date: Thu, 4 Jan 2024 20:30:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rrichter@amd.com>
Subject: RE: [PATCH v4 3/6] cxl: Convert qos_class() to use 'struct cxl_root
 *' directly
Message-ID: <659785e0916b0_11cc4c2945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
 <170441750038.3632067.659502106120894365.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441750038.3632067.659502106120894365.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 282dc652-f4f3-46f4-ca0f-08dc0da70a92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3NGz/+MYh9Hz20wvYSZb97k0O/QzcxR80ThIuUsGO5KqSd6ZqSTtKHXP5da5aeNXfgX0c7vkdGnSgmy+vvtAAiYa5kRIFozaGhFsouh5l+NxM1DFlwK2JlyJSWVcsDDvpZ6EwwYgCbdtuUxm5XPpkPVHiplHMFLOANol7P6nsGkXeCEbmHfT0KDULGuzrng4CcuX0vDva0ctf7t5Wu9B6DLxZOFT8M1MU6OIax6DK4iub/xYDDYlW995LoKr07MOy9bIm/ngZIm8NG4M05whKn63q5GJjcCCl3PC9Rr8NfiGkIPtKwb/+hcH8IcS3gdU0SUZhTEbHovAbfz4BdIvt9a/uwWPvrMU1vWFl8DCoNlxLP5JIgFWgI72jLhmyIcSazslynX4x9xOhSmk4GCrNu9DvV83OlE5soznppDC941M+NnE7vhdJ4tqjiNrKjEjsPdFf3fkXewIDJTZYvpo8hKblt36XWLTrPuBQXhgIO2JJhva5jLSn+yPSv0coIZ+jCJ2t5/qwadYssk+O5vYD30ceXfOOBtp9h88LgVFSOR3IQIAuklZFkMvkyX5DSA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(82960400001)(38100700002)(5660300002)(6512007)(9686003)(6666004)(6506007)(4744005)(2906002)(316002)(66946007)(66556008)(66476007)(6486002)(478600001)(8676002)(8936002)(4326008)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wb314xfoAuLR1ADAtoyUEiC2i9Tg/v73F/nPXZ9iKySPqg2zPvmJE/YZHsx?=
 =?us-ascii?Q?9uwn4YleG0Yfb6cEkIw0mB/dLPfZ0YMdD1OaXSG7PBz3iQWTcCWW6AQQUUch?=
 =?us-ascii?Q?NAvhpDE0w/hPYC+XBOCJfOvsM/mF+TfglQDa0AYt+5xGI3MX6idiIeNBb2qo?=
 =?us-ascii?Q?h571P4BHmMLVCfoP+9aAYE3WI/3iKLJYn1qd534V1cvo6s2Fb/r13l7puesh?=
 =?us-ascii?Q?P0OhwNGnJ4YRayHiUeeEIwynPdogiQbytT1vm9AmIXJltMKPmrnAdBvcE76G?=
 =?us-ascii?Q?NBC16Z9LHlZCPa3QEBb5zow3N5iwy3UYvnIYWwAQ0c53COwISgc947bMRcVi?=
 =?us-ascii?Q?GHVDZfOg58hWpMoMKngENI9PjmsuhrwJSYou/ZOxvnJnJqdH56dHX7Pv4RO7?=
 =?us-ascii?Q?LBMNyO3Q9M5wSljtp6Hqpeeyyo1ybPPIN537X0vRHGLthrSfga1Hl7xNppTU?=
 =?us-ascii?Q?VE8SCuzewd+m711cyaNDd78FkL5Z6+XczvyMhuOswVGnY+puS48uHbleXnAP?=
 =?us-ascii?Q?hyg8Q4kHQCjjwYSobJXc3lhw/hgYvwXljZsUEHclPRCdviH79PPewE5RsM3E?=
 =?us-ascii?Q?GA44PZU560JapxDYuAhnTuDIHI3WDvsvXNfJIe2mKgTY/MjTPEBE6g3Bigud?=
 =?us-ascii?Q?N8sOXBKGRhCZDwpNXK2KikAI5bCccEmRbozbAqcu2L8ecLML6izMSceuJBH/?=
 =?us-ascii?Q?Z5q3SlgjNs99Tn63IN0mJUp965Es8+YZNcw8SrgqYebFllkWiRJ1RrWfZXuN?=
 =?us-ascii?Q?5fbqBdVHYPr0hD4e9L2T2W1eCMrYySR7B5NAfGYynMUBfjwHCaWXiaUlhaF/?=
 =?us-ascii?Q?tTagmbcT1qqE+5TcQiBa1Jk/vhM6EQFOULPXElGWsumdmDtqC/T/T4Ky9SxX?=
 =?us-ascii?Q?gv/NmyTpVXAEPtT7iJm2hbLCrYcAUt5jwy96tverMs1HlZLIygB1S4fHIx2i?=
 =?us-ascii?Q?7erN21DjMX97ZNsSBbHOTLS8Ie23onRw0wKzS6oPD+ZwV9hCH7zVZUhhxwx1?=
 =?us-ascii?Q?/Lm3vNK+kUS4Gxcp3G7nEcPnisI/S13ClNKdhginot+m/bk6XO0fb59N2TAC?=
 =?us-ascii?Q?9ccir6NPAtYLTyrZrmWwKGQCedy7E/Mv1p+h4IFJvfWsaoLJTqFyeLuN5Rlk?=
 =?us-ascii?Q?MtqDJUf2ah/K1lQzMR3kVKKouHL0VS6cQdL77XSjjx/sperFaY40yKBgbav5?=
 =?us-ascii?Q?46GIHehKKPMGczm+woyHmFozL0grKpbgyM9vh4CTJ7wSLvNEhO/+RMMWV5mJ?=
 =?us-ascii?Q?eCKTufcX/fhIbj3cA6zXEB5BLa2OYd+NMMgHkhvdLcS5mc7Y20eoc4eIyteZ?=
 =?us-ascii?Q?A7vgI0j7o5AZ4ZeX5KXes9gUcQpVPeZmynLFcGlwrkN4jke0+Td8HQXSdo/w?=
 =?us-ascii?Q?AKKQcEIUtizufnIEVnOodYJnt7DPg0c4GVmK5b+COxI65TF8EISjPvdPPz9R?=
 =?us-ascii?Q?iOY6Id7iPvzzUt4rWv1jcjZkFJxaUCiral0iHKHhbQt4O+rWSeYGCbNaJvOu?=
 =?us-ascii?Q?gth3L6SuUINBGhgVVH/wqBKu8H86M2OQiRGvHXsKN7Ij4sclOFx9ODW3mS+C?=
 =?us-ascii?Q?hAPOzChciy1fBm8ULNnVKht3x61xcjqqpQE+MU8gTKhSndNX2bu9qTGg1nNv?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 282dc652-f4f3-46f4-ca0f-08dc0da70a92
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 04:30:26.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKw+MtUo9pn3DjK9l913TZqLlPyQWbpZkT+qkqsi4rfXiMpss1q0H4856Q3rl7HOCJOCWrKxMoQqoGO4m7fWyyJt4SVxNcxlojTvaY/yMHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> ->qos_class() is expected to take a 'struct cxl_root *' instead of a
> 'struct cxl_port *'. Convert to directly accepting a 'struct cxl_root *'
> to ensure that the root port device is passed in.

Ah, disregard my comment on the last patch, you came to the same
conclusion. I just think it belongs with the rest of the find_cxl_root()
type conversion patch.
