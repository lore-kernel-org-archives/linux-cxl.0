Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B7179B7
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718165921; cv=fail; b=sNKQo8MQdu5RZTdwpy0OPj9V2vkHfxzTKrzNPWzj55MBPvyhkGl4xjTUfZhtgNUZ9m44xjcnrgdbqH4m0Yyj0wNkK41Q42N6eVOJP/H3HJ2OlNzlplsQcBnaeYjZ6IVM9mEj1wcFjVdiOSyYN2IJAw5+uDfNPcusCxc7/odfCsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718165921; c=relaxed/simple;
	bh=XHsnFN4ZRbPkpWaOzhMlbeXc+z7b3DAQJf+okeO0++g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=brpNcjZVDHEydhhtRQcCeelrt5S5illCKHCPueUxtBaS8IBvo81ZJ/uRHu6HIlh5bmopRGaxT6EOWcquz4KTRHjr2Z2ktClyGysW7vrJ5HYOHMazwp7+Q9adArqeh7SS7cXOgmL9OOQ0uro9VmMYaSpuApzZGD1cx5JLboHB1/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/TikwwB; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/TikwwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718165920; x=1749701920;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XHsnFN4ZRbPkpWaOzhMlbeXc+z7b3DAQJf+okeO0++g=;
  b=H/TikwwBHJ+lmOGUQLT0c4ITX57RaF/7TOP2ycgbPo5Woa5bsbH44s3F
   TpfbzA23l3qzwJS79h3Cs5K6JUz/yGwzf2C/nJ+y6BCA9nu2qwirfTy/c
   TahAdwSKx6cpteCENL7tu7x9nAZdFDgIbn88MuG2kpYZYQ9WgPjnaAcml
   Zl5VhLlAWahTZnIb1REcvY0VkcGNn3bC2AYHZZxWsy8ezcFgTyvYXDI8k
   mtvSZXWPjPINJnb4omWmTMy3lhoxov+cv7fXXnBPy7LxSIIFzusM+syXN
   OyjBF5mqKRDpkwM59E+dZ5MxOVkLNBtrP1ywPLUjPnoFXFnYMPmxU7sya
   g==;
X-CSE-ConnectionGUID: FMxAWUfLTs65igTOkDBdDg==
X-CSE-MsgGUID: wqwBvWScRZiIaDfutmrwdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15134603"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15134603"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:18:38 -0700
X-CSE-ConnectionGUID: 0oHoQ0g0S66/176Z23WiGA==
X-CSE-MsgGUID: Onjb9MTQT3mc03iJFXIO2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39626940"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 21:18:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:18:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:18:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 21:18:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 21:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+EkifVm2HffdIfDiSmIwlrfd0AcHa+vpBgt9fdKX6A4Dz8rX3jbjXwTU+W/HLobhQi4rwTSRTGqnuLHodlC/GWAu1scK4HRRQCwWIWTqcdEroFYEPeC3Zb8fbMeyKy1I6Nye8JyuEH9xARa5EVRP5qzHOTLCuLcqA8+q825YNWnN5/2UiWwIcWl6DhDwutJy/nlEq8PCjrmY7Fe7jvW+gpej7mhh21cdCvrw6VVO6th31/U6lIwgUv6HIkZuqapRC+ZIGzxzvlGTJvGNhRfCIafjSkRQDBcSj4e5cg3ZGDm4CYgmtQZWs9NS8xFxfRturGGbi1CqhAK89KkSgWRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ttbWgGw97R4eR+XExo8WJZhYJZhzK0nCUBY2v9iiZA=;
 b=OYWk1/2pUY+HlBq2axc+RbfMRgcQ1ZIuFFbTjY3FmgzwKQHzFkEJk1oVANbMld6s14qsHGF+7bBoP9mbv9XFs1+sTkWqdvBjYlKc0kHFBIgCNunPhdue5sZ7FBoT0gqp6p4P1Zdj3AOwm1ASXa0msx6WqKdYv4ubHyRDfNqCgcTyHGPlSMk96se9ipM+npYlxBjOnbPzr7/DKJpLPGi/Qcd7CMtooV7lmHxaxsulNTZM8EAY37n8IgiYfo+Rzp7Ral+WF2RIUSdlOBi0EdmNSo7t97CsBSexGsFmnbjcS6hSDBkTgp6S+dvnJSH95BFcc2pQbX2Buk0SDm0iLzHhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 04:18:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 04:18:21 +0000
Date: Tue, 11 Jun 2024 21:18:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Dave Jiang
	<dave.jiang@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v6] cxl/region: check interleave capability
Message-ID: <6669218ae5e20_3101294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
 <d7416f60-28fa-4848-a0cc-61431528db8a@intel.com>
 <OSZPR01MB645395AF8FCF7C485ADA193B8DC02@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB645395AF8FCF7C485ADA193B8DC02@OSZPR01MB6453.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b85e812-b069-4f5e-fcb8-08dc8a96b1a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|366008|376006|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0pkyHdumVq85Vr+DXFw2i1ofVMvjSPW3Dc4FpulWuSyo5mxJkaZ4KaVw5FIe?=
 =?us-ascii?Q?IfJURr/bK181jyxOmC9fZ/oxKiQmcpDtHzODsF9FNvXBlcKAsG6Yf4RXgU+r?=
 =?us-ascii?Q?uqp/+zdDMLuPdTgYdlp3McDVXFrJ6oJxDUlAYXJeGqNl5hWrXLbhmrslRYnd?=
 =?us-ascii?Q?+aGm3Z25Vtf+NMjykMSE82POAVFf+KBjc6Hp2VMu+IkvuhGlOgzdaQwSTc/7?=
 =?us-ascii?Q?rLE4a4eJc229vk+xTd9CLMUB6OvdEYWdNmOtpBB6+7iuDFm/MroInK3cdkIn?=
 =?us-ascii?Q?vr+xVfxVZb+vADqygMTcrLwrkC5IFkZbD/XZWBnnMQ59CZCCP+9sOpSdF0e4?=
 =?us-ascii?Q?V5fr/OFalBIgJQjNL/EvOEMsMYTO1LthThH9lBK4jc+smLlb9Er1ZweXkPBH?=
 =?us-ascii?Q?3sRpcUxkC2tqbqFnlIiZxg+AfVjIUHTKy/ev8Vv9sBS6BSwcTPsJsSVCdBdP?=
 =?us-ascii?Q?Al9E4QR1s2SX9A58zzLu/KGriLrLVr0RqRuMR19xqwjJfGlG38LZq9xXYTzc?=
 =?us-ascii?Q?yQWn4CkJ4QlJsT4EhTSbainyHID/vT5bTvGkUVrGCMF+7+04V7csHDohRCMc?=
 =?us-ascii?Q?ajAUHiviP+XrumQsvAkwoI/zHlSBYEXatXeYk+db++jvnGwZUcjUns5lLBnv?=
 =?us-ascii?Q?InM9hdHgpJ81J/Z9AssOpGaiFoRbuTjbe/82gBvIZVwqb9qTVHvQmSkevanc?=
 =?us-ascii?Q?z4V3kh1rWoLLrDneeFdtNpVayfFCCKpAb8Reo5CdWqsxJ7EB49X/9V9ysET/?=
 =?us-ascii?Q?mPyN+vibx3iL5npvmoa+/gWWgdWov/O1Tkey5nWAnVwGn9Wyc2KqeKYt2/SZ?=
 =?us-ascii?Q?hrRzaAbTQxcMYJxVcSZIu2Rmn6JzcA9q3ry1KiYtAlS8h89W95O7yg//SNiY?=
 =?us-ascii?Q?RTanovymXGjVbm8u4O77K4y4GVHkow8mgTB4gzdMv7kr/8CTAk9T3daXfVUQ?=
 =?us-ascii?Q?G0MyO1JhcCKThsSms7nEqm8nzsWPIjACVuacfBH5C2TT91D3e284T0JAiFd1?=
 =?us-ascii?Q?z8l8/yj2ohQId2Df/xSnDHHUnaoGEjkcEdwdKO2h0mKvp9Bd5Q4rIFWpv0bY?=
 =?us-ascii?Q?tODCL6xqAN5Ff/llL0fryhTk7lj2ZWgSjRQz7Ao/zB3VYx4Fy81Y3/lhfc/8?=
 =?us-ascii?Q?NteEL4TdMGqUkGJogW4JZ4CG0mjWPonUSooC5yOv11DK06bLTltk3gG5jJvb?=
 =?us-ascii?Q?Njfyw1ZtrJ9VEy+Z/Gb0EluhgXVpQGTXiSApjqJ+gOCGX+pcdUn+xrNIdGkO?=
 =?us-ascii?Q?W7zYxmMxz7Juxn8QuTcaIdHGo2wyWD+Cvet/VqoXcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(366008)(376006)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QoCMigrVbl3V5mZl8EhI1zZi/kBIUqiVuo+0qAfA6uzBYrYwTnoT4d3/L9GS?=
 =?us-ascii?Q?QuP0wZg0TUgbQe6it6rHs1x+mUtWSOuyEaG3uCcxyzv+87hny9jXg+q2O130?=
 =?us-ascii?Q?Yb1h6sUsiJDA2rXhnJ1S4sW9c5iNQSrrJxuqplujqo0RjP31tV9NL7PQrZ2X?=
 =?us-ascii?Q?CKgIXfzJe1MvxnmIVw9VoADwmWBZwq62uUecn1MFILSYQ1AI8CdqAdtbpPKA?=
 =?us-ascii?Q?E2J3RERRGhDQOj9k+8HbGfHhFXvCzwR2/TEuGAzQyr1y4EP0dKV+grO8rIPv?=
 =?us-ascii?Q?3pLk5hA9EvG0U8zeFgm8RoMS3Ox72tNmZHyXounTHh1h5lfqq0Tzve/W8+SC?=
 =?us-ascii?Q?6ZJ1FQbBDCAXcY1HncVu6B4rKhHJfOBnsY8Zl8y2IzQR8XvYGDeQF7Mch2Yz?=
 =?us-ascii?Q?cY0Y9CD5KmliZTC/OAOXwo2zpr5BynoSbIsxcNEMmBTN5FiNHo2FZTDzovlq?=
 =?us-ascii?Q?xKmecnpToRz1FKLN/I6Arpsp7T1GflQoTIbWDR5TWMhg0Q21rDkdTu34nIez?=
 =?us-ascii?Q?7kQc8q69Rn0NE1ji3E07+nU0uRpfMM0qN2sgah1qciTJWuZO4OzWPIZvbojq?=
 =?us-ascii?Q?e7BA+57yM4HEj3/CmcnCYEbEjqfuNKjVdbwnRn1Eh8DNC0o4r+x6xQcDPJ1w?=
 =?us-ascii?Q?LmKmxLehuQ3BFrjVv6PRXMVIsFf3PWyyN0ankxFwSq/jptOj4PdBKs01ttCj?=
 =?us-ascii?Q?yXP4X+mrJ4eA+OqcQF2NqN5Z2CwKbszOQ9Ae8ZZm+GybTz0J7i8aLsM369D+?=
 =?us-ascii?Q?pBP7rvkUqYoz9KfE7YX21wqp2OnyB8jOO1lmwBdKweis/su5n/0mD2Dffae9?=
 =?us-ascii?Q?nPT1Tb+10ncqw0vi8NYH1UtnKw+kFohThiSBhgtTMBvjIDFrI6v8GzURcGQW?=
 =?us-ascii?Q?6DvzfEVZpvWU9daUM5AysBpC32F3lDxho5ocwG+rFPi9uTtTX9U0Cvb3eqls?=
 =?us-ascii?Q?nLNO16HsG3d1kg7vnEs/8FyfMgdXMCWebooGTPtUVNnGyApEbZMODp9SxiRG?=
 =?us-ascii?Q?sIl4HV3FOlGGi+pegrKlPPG6UwJw1Fvgu47ZmWqatoLwJdFZx82YqSt7wTxC?=
 =?us-ascii?Q?3S722G2OOK3JXC4yHvdNLxLCNi5tud3dc6MhPnINmHYT79hNaRUzOCa4zlA8?=
 =?us-ascii?Q?W4FzyyLTXYvxEkSLdy3UmomSTF3ssCvnskTcafvufaY/t+Qvk9LpFPXSkeYS?=
 =?us-ascii?Q?xfNSYsyZQrqWeiPY/17B8CuU4rvo7lxL1DTogMSe626rVXfPiVYQ4YPngxST?=
 =?us-ascii?Q?FJoZZMCzsP3cdHUtNTiImfg3Evxadbnr3ZAHV8eM66JIrF94nNicrOm9WxqM?=
 =?us-ascii?Q?3sBsxAtl6iWGKvmb9ItJe6tfc0TVwsrlyI2uyDWQiTBfRWtK+x/Uu+3A95L/?=
 =?us-ascii?Q?Zfyh0fHg7zCTdvvJfx+fyWdtxH17azCveNEVAvLY24pyxvSpPgbNlZZTXTJg?=
 =?us-ascii?Q?nCqqb9ZChkCyWZNm9X9jFCAsVPIoOlVblF7NbxNec2ef1vW3HCrjno7iKKG2?=
 =?us-ascii?Q?owRCzYYQC+K4jgQqRe3JxTiPdtgsW31nZElM6Qz08BB16XKe9QDCQgRne73i?=
 =?us-ascii?Q?bk28I+P1wSWbaMxtjIask1m++N3utjgykwSWbRt5Zieo4RRw1Qtd4iaI+JoV?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b85e812-b069-4f5e-fcb8-08dc8a96b1a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 04:18:21.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s2Fl07fSTdzTzRRTBZ5nZAq13+rN2+Mj0LS3y0roHGwsUmFroxTtAkCtjb35nq/h6hav77KeVsDZm/9G7MeWe+Ia01j45R7WjInHF86y/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8464
X-OriginatorOrg: intel.com

Xingtao Yao (Fujitsu) wrote:
[..]
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 5c186e0a39b9..2716678df5db 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1101,6 +1101,26 @@ static int cxl_port_attach_region(struct cxl_port *port,
> > >  	}
> > >  	cxld = cxl_rr->decoder;
> > >
> > > +	/*
> > > +	 * the number of targets should not exceed the target_count
> > > +	 * of the decoder
> > > +	 */
> > > +	if (is_switch_decoder(&cxld->dev)) {
> > > +		struct cxl_switch_decoder *cxlsd;
> > > +
> > > +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > > +		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
> > > +			dev_dbg(&cxlr->dev,
> > > +				"%s:%s %s add: %s:%s @ %d overflows
> > targets: %d\n",
> > > +				dev_name(port->uport_dev),
> > dev_name(&port->dev),
> > > +				dev_name(&cxld->dev),
> > dev_name(&cxlmd->dev),
> > > +				dev_name(&cxled->cxld.dev), pos,
> > > +				cxlsd->nr_targets);
> > > +			rc = -ENXIO;
> > > +			goto out_erase;
> > > +		}
> > > +	}
> > > +
> > 
> > Should this be a seaprate patch? Seems to be outside the purpose of interleave
> > capability check.
> in this case, the cxl_rr->nr_targets is increasing, it cannot represent interleave ways, and the 
> granularity is unknown, so I think it is better to do this check here.

Right, the decoder's target count *is* a capability, so might as well
include all the capability checks in this fix.

> 
> > 
> > >  	rc = cxl_rr_ep_add(cxl_rr, cxled);
> > >  	if (rc) {
> > >  		dev_dbg(&cxlr->dev,
> > > @@ -1210,6 +1230,57 @@ static int check_last_peer(struct
> > cxl_endpoint_decoder *cxled,
> > >  	return 0;
> > >  }
> > >
> > > +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> > > +{
> > > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> > > +	unsigned int interleave_mask;
> > > +	u8 eiw;
> > > +	u16 eig;
> > > +	int rc, high_pos, low_pos;
> > > +
> > > +	rc = ways_to_eiw(iw, &eiw);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> > > +		return -ENXIO;
> > 
> > This test can be moved above the ways_to_eiw() call? No need to do ways_to_eiw()
> > if this fails?
> in my opinion, the interleave ways should be valid first.

The check can just be dropped altogether becuase it is redundant with
earlier checks of the same:

cxl_port_setup_targets():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cxl/core/region.c#n1297

interleave_ways_store():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cxl/core/region.c#n498
