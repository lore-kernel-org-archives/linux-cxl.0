Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47C3C3F40
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494024; cv=fail; b=QBPntAjKVjkFd6MPex8F1bWUoG9NoK8ouWba/8Y10uXwIjETPRwlSA2zQ2wrrihPBdHWOsNvPGu5BNZfQ1H67Gv3A3sG7XC5XqosYpFzIgCWuzI65oUKX13200sugSVfU+AiquwX9hl6LpcHACViGDZgFJK99Ww+RAoRKqG8h0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494024; c=relaxed/simple;
	bh=MnCdHbKg40qbwnAE08pGeXi9wLDRqzcrgQanZnUsmCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CyuBNxG2PSuDZ9Sym9hD37rNGVzeptR9PSfqKpSLelhtQXRPLLXdHR6N4APHio4lZ/9JVEHQzLV5n1UU23ArtgzuxnxsVAIqOlIwD7q1LM/WFcWeOrABTzJT5nrqh59yEvZNLjPBixTvcbZk3nGDo5/cWL/fnkDaQaf6JiIsZ5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzZf413I; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzZf413I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788494022; x=1820030022;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MnCdHbKg40qbwnAE08pGeXi9wLDRqzcrgQanZnUsmCo=;
  b=JzZf413IKgq8IZbTJaJsWJTjpdNqctdgqIsgSrdQO3UVh2kxxz+dCLWq
   xw2sfZL5sE06BYH48hTU0xtKeVnhMZbx7Ql990JcgCIbRTyZGW022TRHh
   OKJW7BvCqLoe/5omD7mZBUjxp0ofXSSHv3fcLHT5pAE+GxKZbQhST3Hj6
   tiAW/UZfLKL8DXtx6Q9+AiXOpAYCNdVHE9ofJhKalYzfZ6ye7zebwrqYF
   JyvJ/XhZhxtzlDeCp58AYB2fgCybpQzcEZgdgIu2eAjAhQMGFPVfmZFUM
   r/67cNiq2cbMjWUE8ybunZfN3ruoJXUMh6FaN/wtoiXDLKm6nio03dpXJ
   A==;
X-CSE-ConnectionGUID: X6qjSytTTe6eY8K+h0K7Mw==
X-CSE-MsgGUID: g8uuje/SSSidHy9PXYNakg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88837422"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88837422"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:53:42 -0700
X-CSE-ConnectionGUID: rraj/1EARbmabkXZgrZ/yA==
X-CSE-MsgGUID: 4oGPNlQLSaaC7u9cZz5fpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266238698"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:53:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 20:53:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 20:53:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 20:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZPZDLhtkaSafm7nDq5dZuvfWWu96ui9Y/Qiprn/NZuy36+XkSSJpoud0YjG/MieGriQoESHZXfbhidHh+Yh08MB5OyQnUamqEbq/gESrx+c2B9qg6FzGVMyydZutuVcBSqtNVKTXCsGYntjIVt8YcnVmsM4xtl4aZclMd/M2E6qJky8yf6Iv7xD+AVN/03x5BUbp9ImH++KFF0W8XJe30RD9Q3qSJa/AsyFQiFVJ2kn1lI8nZDV/1Xkr14CWdtkqO1P+Zjvb61IypkI25VKFN52kVHr+h7g2l0+3KfwRw6fLubdlkNZKnZRpT38g9P3uIA1vM5JorJIx+VjFNLSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66+9bl+qBuiCeQO/5HpX+dV88IWOFp+lNFpeUE+6dxc=;
 b=d5uvc/R5fa+AfaevK8Xc7g2UKIufMYojmRTHKSUoAyoM2vvBlEhGaA3o4M2VE77EYj+EfaVm31dIrk8Y7k3Wy4S1aJh17B+7yTCwTAYJUa9WiOWXNPsOp3ut5mVfWsUmeG+TISAnEGd0CB3OQNUmesoJygQ6v/xZEFkwj32vzvKnXph6Gk/j27B86Rz3+H3AR5LZvPlutO8uFpgQ09gIaK8hVzWLDiSyq6V/Ftmr8UusdyH4I0NxPsPsDV4481sFisW74YBIUbuN4dmNPqoO1D+z3egG5KcOdCc6CfRpKohAghOtkDLu2lTbfejCICcoNQBfbjLmoVzWAzUIiPBlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH3PPF310D5CFFC.namprd11.prod.outlook.com (2603:10b6:518:1::d14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 03:53:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:53:37 +0000
Date: Thu, 3 Sep 2026 20:53:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/region: Allow regions with an unencodable
 passthrough granularity
Message-ID: <appAvulhn7-X13HD@aschofie-mobl2.lan>
References: <cover.1788487020.git.alison.schofield@intel.com>
 <35566fc6397183a8be89055d1de9979eab9a24a5.1788487020.git.alison.schofield@intel.com>
 <20260904033624.D58651F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904033624.D58651F00A3D@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH3PPF310D5CFFC:EE_
X-MS-Office365-Filtering-Correlation-Id: a8aecda8-8993-4d18-97c4-08df0a3819ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4dMnZyqVhpNhWVwm14ubci9u33cWKgtSRc2Ezhyd07ZfG+UInKOKonlgQUiwUMq72caKl38mscll1gs6dn0j9/fnZlcomkGfAs2Y64ke07WH5e71RkxD4Q6VsoP+D8/6LLwuuT41ZQyTOEVIJ8AR+DfyqJwiJ7napGkwwsBSPXRqaOCrK5rW1I/1YtXLwKW4AbGvcOT7r2UpEoNMz6lDBIB2e7RULMVkz6eK+9BdZMop5yyJTX59WVbehNiqaTrgY5EV7KiowCBKhXeJIRV01KoZCkMPkL5PzBPxVS505nvYqqJhNBKExR9SpgslGQRR7PnKj4QvSSVVem/K3f+890z/fDpBKgMWeZTOmgxRJ7O7QRYcSoQ63GPMs/nSH5qR3xjx48LEVJ8akcMQgP67kRRe04+7YMO5I65GT5WmAyaQa06Z37/3xvF2gpVRq/Fsj56YpGbXQE3+75xrug4aKYgV2LdM3m55hwWDXyqtlcx1R0UsaUmPHZcBEUu7OTQaRhbWfos4wuXJFBzezDA08l+6kw8SzPo4/woA2R8jA7nc8rwxo3acrqzZhXIFys5GUgOWE6jh9C7TQVe8g5U+Sv2yqui7lnvyVPjKmeriGkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FJB5WIOWZ/e2nOvi0qi01yV9rIy35Wp8xDPEdvKbaZJkJQUQv9N2cZz6Qr?=
 =?iso-8859-1?Q?k+CQOA99tztziZzWcTR0RI+oyeMB9qWcE8yNLviAgRbZ0f+9jboh61kvAI?=
 =?iso-8859-1?Q?t/54lVeBt0532GNlDfUOnz6N1d5wVu1xVMyVXclqeXzsnyCKgI1x9Rz+Hk?=
 =?iso-8859-1?Q?VoStU2mnRZTzi6xihtPBaBqEKq2WZctNIoVKFq74g3teuDFsyfwcXb26VS?=
 =?iso-8859-1?Q?jRkmWnQn3RKcxEMV692QMLf8pfqljFPeCHyqfY+M2qFXyLjwCongiZNQ69?=
 =?iso-8859-1?Q?ksTJqruwF63pMt4IeiL+XUYfkzTS/t3kJw3usypcQfXTbqNWH0X6IRv4Rd?=
 =?iso-8859-1?Q?767cIvle4u3ohdgFq+kkU6RQLzBRz07UVMJOfaW2kBtxk+EHpH2QH+N9Uv?=
 =?iso-8859-1?Q?m3WUKAeqhhX6w9xVDoe5AjsTJfXDeCUV8k6n/x6174OlmvAzWEqGdn2nkm?=
 =?iso-8859-1?Q?grk1YSe/DcO+6RLAfGECUUr0w5PGSP/IWLiRzSuOwQ0qRVvJghqCp0sq8D?=
 =?iso-8859-1?Q?59R6vQhDITmPR/GYE0u5Jr3wdboCTn99VLwAiD9N8cQAwS9Gp5XvitHNhN?=
 =?iso-8859-1?Q?5V0s8kXBx9Yeq7qdVNs0LFmZ/K88wcaal0Ctq2LUoDkIaauc8maIY9u9uf?=
 =?iso-8859-1?Q?2gyVbtHXcB2zLwxnIDaA2NWdVIfXCvbqoqoGULjFy/RcxphchKe70MB3kN?=
 =?iso-8859-1?Q?vdE6hYeIZcos3huNulIT96dGXP4xF0GBzlii6JrN+x2G3KFEsp5C07N/5p?=
 =?iso-8859-1?Q?CGyFm2FXtXNspmAxFO2CcJvmofPMkbT6Nky5OaU7sQFcglxvoUisLyHQo2?=
 =?iso-8859-1?Q?j5VrAeQ1t81z9zKFBh9XPtioN3BPq1r2YjktGFsARsIoljXY7BqyN2X+O8?=
 =?iso-8859-1?Q?2xQKeKGwPrBm1BsNHZv96tI6WoHcd38jwYdV6BlrLaVkAPLbAhNqXBZaMY?=
 =?iso-8859-1?Q?lslCdAi3Ij8ursE8Zk/JC+MvYG/wY3m7MHg2vvP7vVejPdaGYysoUKZQ8z?=
 =?iso-8859-1?Q?R28rBZ49mzdgW3Heb5K2Y9LxCtoVNxjft2JyYgCImJz8CT5GXa90eyUuv/?=
 =?iso-8859-1?Q?7RXfDRa4ZXvDn12Kq1Az5SQ7owJoin4af6+7E2vE8/ylRy2dwKj9Kx4jK+?=
 =?iso-8859-1?Q?qgxvI2FeF0VIHXKlQNbaKki7fuCFewk1I0RrBLYgG8XYerq5BTQlDldj6w?=
 =?iso-8859-1?Q?HAH+HyM4hNxjW40IEsYHwZcUl8JTm0xznGv1LKxeB6ZsUZIQ562qWR/ih6?=
 =?iso-8859-1?Q?5ggjq2qQtMoxW4piFJPlpf0MgalkbbHO9fjOgnA6b0T6cTYbXMeEqj3zfV?=
 =?iso-8859-1?Q?2x2KY1jslIDIBo14BwwZDUZBVVWsYVJu+DZfECnnpoFIOI3nemcS6yUtXx?=
 =?iso-8859-1?Q?edg3EDihkF4d4JqSW6/AA69IbOJM0ZMOA37L6Id/jj2OQTQTcPnuJcvIyc?=
 =?iso-8859-1?Q?F98zDkV79ERDW/0OAQnNvuUI5ItPj+30fziR5uXeqIGHdhO9ppgK11gabP?=
 =?iso-8859-1?Q?ab9pmWsphYD1+VW23DIhkfPfXdfWMdnOy32kmSvRGMwIFlLtpoteIvGRZK?=
 =?iso-8859-1?Q?j4LHlFvBcKQ+nls3R7LegUFROHP/lWiy6XQXJsI47o4a226hVkvc9I/ICh?=
 =?iso-8859-1?Q?QiFJJM5M9gKWMM6B3u7+3eRAaAbnLjlWxTyK/L2iwG2OoA3EiqDkdXHKet?=
 =?iso-8859-1?Q?SNA5cPW8FrleKnhOZjmMvvsH02rQ9tAQ1IwBG4JKbFH37rrufYY0+oBhDi?=
 =?iso-8859-1?Q?5gL/hOgFd93yar0mE7r1ZjyxMtE3vviZ5xteoDX5JnAZRluZZpbd7JoWWw?=
 =?iso-8859-1?Q?j0tYF9bbeLxRpEpdSROI7qR7JUwwUEo=3D?=
X-Exchange-RoutingPolicyChecked: jcGVYIU4aJ+AQ9P/lflUq4CHvkB1Sv17jSJZUsh8x4drFs1E1X8q2Fb/B131T+BYSulTCdUajQTCR5nbi0eDDSuLmb0C4w45pkMHD7sm3BKUyqdIZ4XRJxlMS1Th9K0tQi2wbcN5cSoJpvCPRR+L8NmhTUc0yzvtXd/z/jknTNoJM2FZ+xiYpkwJD4ZTjK8T/vAeYF7FrzM1u2WnBTv3TLlEF+dOk2Fq/nYqQzoGW52bca7DVBMWyDyl9UJingKPeE00+4igquhpq0kWbzvKWvZwURq0uMsjWcD8M7+2JdzpmR2GFJYAiDcScmAQmOXKUccYe+FCFsnVYAeook4V/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aecda8-8993-4d18-97c4-08df0a3819ae
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 03:53:37.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJtuHFDGzqth5lyh8PcNODmimGvAI6/kWLrPjAnHpi/uD3yReIy9Spmopglh9qBDditOiTpd3Tvcvtw6YsN48hIoj1jX9jXTP4xlOzZ7ogI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF310D5CFFC
X-OriginatorOrg: intel.com

On Fri, Sep 04, 2026 at 03:36:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] During region auto-discovery, the driver relaxes the interleave granularity validation for non-interleaving passthrough decoders, but fails to update the decoder's software struct (`cxld->interleave_granularity`) with the computed logical value. As a result, descendant decoders inherit a stale hardware don't-care value.

Same NO as in v1[1] (and in v2, v3)
Gratuitously updating the field is not the right thing to do.


[1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
No. A downstream decoder can't inherit an unecodable value into a failing
check. A >16K granularity only appears below a wide interleave, and
everything below that inherits an equal-or-larger value that an interleaving
decoder couldn't encode. So every descendant is necessarily passthrough and
never validates granularity. There is no path where updating the F_AUTO
value would prevent a failure because the failure cannot happen.


> --
> 
> commit 581b6f11f4646ac877c9eaf9fb81a155a40889d5
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Allow regions with an unencodable passthrough granularity
> 
> Region creation fails when the interleave granularity accumulated below the
> root decoder exceeds 16K, the maximum encodable in the HDM Decoder Control
> IG field, even when the decoder that computes it does not interleave.
> 
> This patch keeps the computed value for passthrough decoders so it can
> seed descendant decoder setup.
> 
> Closes: https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 27e63e6dab7c8..89693f0181ddb 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -1550,20 +1562,12 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	 * Interleave granularity is a multiple of @parent_port granularity.
> >  	 * Multiplier is the parent port interleave ways.
> >  	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > -	if (rc) {
> > +	ig = parent_ig * parent_iw;
> > +	if (!granularity_is_valid(iw, ig)) {
> >  		dev_dbg(&cxlr->dev,
> >  			"%s: invalid granularity calculation (%d * %d)\n",
> >  			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > -		return rc;
> > -	}
> > -
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > +		return -EINVAL;
> >  	}
> >  
> >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> 
> [Severity: High]
> During region auto-discovery, the driver relaxes the interleave granularity
> validation for non-interleaving passthrough decoders. However, looking at the
> CXL_REGION_F_AUTO block immediately following this diff in
> drivers/cxl/core/region.c:cxl_port_setup_targets():
> 
> 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 		if (cxld->interleave_ways != iw ||
> 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> 			dev_err(&cxlr->dev,
> 
> When iw == 1, does this code fail to update cxld->interleave_granularity
> with the computed logical ig?
> 
> If cxld->interleave_granularity is not updated, it seems descendant decoders
> will inherit a stale hardware don't-care value instead of the true accumulated
> granularity. Could this cause the kernel to accept physically broken topologies
> during auto-discovery, potentially leading to silent memory corruption or
> Machine Check Exceptions (MCEs) when the region is accessed?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1788487020.git.alison.schofield@intel.com?part=1
