Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A43A1DB
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822202; cv=fail; b=ezq5tcdPU2o/+/kU/26taUTJrBJoRwffeiMfRjA2L1clJXWE/e0q10aWVOuUiiNuuGMEZitHNn7i1HPcLVN67/0o+sRq74bjxfd3VdRvi08BhhtVRCpQ9sZxqKSlPy4L2viQqd5FfvH8AoLAluhVm0eliz5sfNqclEztE7cMK44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822202; c=relaxed/simple;
	bh=jOaRO+gvtKxLFPRBjrTK6AsxWZlchn82pZN2wlqN50o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chkfdZPBZdZRWzWXYC8RZE+CnewS09goYPhvGZVrvnd/F6hgRENZJIfs1Rl/ApZpPZbXpLl0YOAPTDaMoloO4Xdx0jPJArqiIZU3Kw5j3SZYp66/TXqVwsG3YcUPhDDYes0EsXJFm0enMcKy9FDJNHiu4xOa5DpIMRCOY617bJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWGPY9T0; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWGPY9T0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783822200; x=1815358200;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jOaRO+gvtKxLFPRBjrTK6AsxWZlchn82pZN2wlqN50o=;
  b=NWGPY9T0BScjxCXH6fZ2hMlEt6rO1wPURKQGG2NOrYVgJQWOwqHtEKZV
   g7wtY7fNOnehEoRvRvi5C8cR5vChxDVxGT2ILIZ7/xZ82RXmO40Dxm7f8
   ntcPUIBgzE1MH9O0atIq6Q3RH6pehFEpciyU/GT2upQGJv+Tpo2ap/uds
   C+49c0oJYtDaN5CHfmjFCjT4Wg7lxMDksT175HbJHEPHDdbyW8dVOVigE
   GmtqA2OO6eNKn1KiNo+OHIlGiHqovB4Ay6ynf88+8LJK0o0AJMbv8OSHI
   LQdvLdUr39OFnkcyuyR5ymSwlrd5WqRAb88FEn8xl7Rphxefm9jwku6Sb
   w==;
X-CSE-ConnectionGUID: 67kdCYpYT0+l+cRtCWOO4g==
X-CSE-MsgGUID: 6lC3lQe8TTGROF2ETnylNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87019764"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87019764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 19:09:59 -0700
X-CSE-ConnectionGUID: j3wJGYGIQXKMUR4YW7JWpQ==
X-CSE-MsgGUID: uZkskla3RRO3ydT0JyWBGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278468789"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 19:09:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 19:09:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 11 Jul 2026 19:09:58 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 19:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLH5wY+VsdBItZoe4wwqVCZGEdeqP9LcoIwNjbwvvsEe+Iq9ZXImyBcOIFLiQNB1i6kIIqhhQ8acqGFLxX6AnX8ED1/YQBSUZHnd9u6UQpadM3DgKKISeCn5RwOCvOPNgDMn8GaibY8QA7g36Al4PUBwRiciVjVCPZjyVOSps+pRNLlWyjW5lvATbAEVGfHfhPsQBxzhTE08ZXL5/LvrJMmc0dsEDE2hwrInApEJ8xSF8E850W8KT4ksJ5ihwGYblLiMCC8QMV0iKu+SIMcFD+bO+diiQhUvFHhz4Qg1kXV4sFQyvKKJQUZK2Mnk7ILcnUEmzxPldeyj3tQRGF66Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w6r1LDVaNsrnakBQ33bV62USHi7XvpP/fpO9Ph0Bkw=;
 b=SvRAgydlsDQJNjek20WD7lhUa8iVLAxO3GnNyBjkWZjRMqehjloj4+eXVfXeJmhKL/Kw5ysUNxuFmHJL6VtOv9KDT2DPEcEOxxvbHqjgMBx3uNAmGGWLC3Td4IZyuoAKU/CVWDWRuIYp4zPsiCQGWWKzli3skbDYUxAj/9I8buLs6f0IfcVUMI+UXlTH/zsm2NGTfjhsH5+JCeSBQUOr1/vWRsMotBBPeRS3t/vy5ilfqWa4UFjjEtMBQqtOTZkvjHA7iHjLLzM5S/7GyzASZtc50NuScs9oMvPD/WMWXjLJ1pYoGKeXLcWQNID/oid+bQG+HUZ1g8zs/pzmdicCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPF382351574.namprd11.prod.outlook.com (2603:10b6:f:fc02::1d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 02:09:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 02:09:50 +0000
Date: Sat, 11 Jul 2026 19:09:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
 <20260711201508.082531F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711201508.082531F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPF382351574:EE_
X-MS-Office365-Filtering-Correlation-Id: 111d07ba-100c-44bc-f07c-08dedfbaa7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: cpMJWynE0EPzzyJNkpqItSa11T/Dqs+Zb6bTWvxjFuTgBo6WlYKQlLZC6gYM9uqWBHg5jar/WpWB5tu8Ly8YUu2KQgsGf9cCrlI5CdguTXn1GqSejytIWY5SuTwSkB9d0pgx+A71WkJUH1JTX6LzWOC8TNu+fbFSt5SbpOitgXgNs0dY6fo+m3wI/zCwjuRrVMKxl7npXk1AoxGdbD+z8zsrtG7lDflLnyMBu9HYRSGoggvzhOVl3TEUb6+uYnszHQ+j/AbbxBoEs1e/6l7fgSVUv+9vLxh6cetB2ILVlqkjZSoRViUqJHSJQULa+yxKNI+cmGxe18ibUH4OGmDm5N15EBkobNBCRM1AO2vBFr/gSGon1LBVhO2u7uoE67GxKDKnhXmSYs6NJpgBPOGVAdWveZMTgG4WHETfYWJRw9PmTDuWt4nNozURyTe8xK0+sPFjjhMeM/TkD0/feHmJMAyYURwL86WTQBfesTZdMSJsnLLowAe9KO2Ps+blTY9PfzY72/nj7LVG24TF3itzyWBmPD8VBgWwSAO58xBS944BvA8SW3K7U1uqG8NGuXfSQs+KICa5vF+o7PT8aMsBPn3yWGQgLy9A3YdqbKWbJPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?laTUDgPEBWLh6xAr3rbe33di9yT219R5jfg5U7ivRaDXytB5IbXqjGZKpv?=
 =?iso-8859-1?Q?Mqj2zjgz1NUBswiV7vN620kDPuOKWOlcqc0cOsxMpC95rFBOvsrdQbXkpk?=
 =?iso-8859-1?Q?5zHlIGbaialfuCRh40CZXW+BeIN8Z2SBYQkrrY1ledQ7cR82LHjuXgYPSK?=
 =?iso-8859-1?Q?Gj1N8pGIyMQkkRTVvBDBO16YSdnnOF1nZnDy/1y0fFFkR0ybCSiZuGSmtU?=
 =?iso-8859-1?Q?MEHKv0JuuF7yr6aa0sKgv/VgeAKAF/SUwkImGNwWRqc3aAatTAYDp7TQsM?=
 =?iso-8859-1?Q?ibKBe0vJtVnLH5bR7ap6q/u7mCkSQHt5e+XPS+ggIYMlprb0ahAC2gB0hF?=
 =?iso-8859-1?Q?4O5MLHt7V7llLqd2Rg6OTYNLs2h7IJmol3yeDukgRDP2Mn4q4HJIf3H00u?=
 =?iso-8859-1?Q?668+J6oEWeBKk/4TJSkfKtq3FWNppwtLSJVKNcVVH4LWJWNn1xjRuMRHep?=
 =?iso-8859-1?Q?IE0P9xFzWXHhNyn6QiVsmHbHhSQVv8ml7zBcIbwKCQ2H7EjPvTZMO9WYU5?=
 =?iso-8859-1?Q?A8d0JED3hcIzEuEgoC7TK/lIL5J8BhwNoq+IQ3Q1E/uy4ms1Mlrq8Uhnoq?=
 =?iso-8859-1?Q?9FZ79pab8iFibSi9TSTjadUuIhCr92tLO/n+0JoheZWYsh/abqNRKJ+6ap?=
 =?iso-8859-1?Q?OZuBOgnyXRJP/Ajma3NDPxqXEiq2+nTJAlZfD9AvobZEeDsdgpyXK0c4qS?=
 =?iso-8859-1?Q?EfHr5vEGQ1heLGtsNu0ZJyoNTvQp8oN2jEnSOCShCVKMHs/AQD5t8v4/qb?=
 =?iso-8859-1?Q?jrHafqWfG1QiewSC+iLcvzpvtV4y3vrgKk4tkR0sKNKjBcYk6ApDea2U8y?=
 =?iso-8859-1?Q?oN+Sau3bEbX/3g63j9u2XPiHvVa8gT0VLvLzg9f/9Ba+iKCTqgeiavvku1?=
 =?iso-8859-1?Q?2BiBX1dG8CLzIUtWEL2dAzjU3pfx7OjJFyXsV3233XHwvLXCC7KazR2pXi?=
 =?iso-8859-1?Q?+Ayhj1h4g8MTOTRAJizZKiDsWX6Qz3+FpQWuJPor5mB6FiJjQPTnkSI3sk?=
 =?iso-8859-1?Q?CWbwb6aaNnRRb0mSE+796AtG3bkZdEotUU7qqQL/yLirdo2GQR2vTJQXCJ?=
 =?iso-8859-1?Q?ErIJsfvf2Oi+UjXqE9HLZmoiGm+znJFrCnt4dhwd0LpGuRN9BOaVCaac4c?=
 =?iso-8859-1?Q?KZwxw9eMWGuafW9e+dKUKFi6tmoMrxL6P0ezJ1tLU4HUXfPaGTabnTexFa?=
 =?iso-8859-1?Q?M5PjpnyGjf1g4Bled52PQ/BBUMUNXAbq4N6Hk3/9mHOjpLNb1QObyPk3tl?=
 =?iso-8859-1?Q?4lyjMIwolMUjNjfeJedjmzbjVfTaTkOWwXgZyN7rnl0sDnn0KihAcG7Ezm?=
 =?iso-8859-1?Q?wFDBIi+hrJ+ASs4dz92iAYCtsgfo0ZHwrTuFn/BFq1XCUCP46ze9/FdUvF?=
 =?iso-8859-1?Q?kivGqPjPTQd0mhJKqLkG3jhY8ffky9iv5BJSfCae1mvrJk2ychY7nM1Ojw?=
 =?iso-8859-1?Q?qgudlVvqE5++57tuVvtI7GSP+jeLMqfB4A04t7MX0pVzwHTNzYgylQxaTX?=
 =?iso-8859-1?Q?l3K+pSnuf4MVKQxkqy815NxTqoWdxnUYDK/UecKPUIdd5HX7phFQlrWLKi?=
 =?iso-8859-1?Q?b388MxrCcFKG9X0BPT+GWrzC0Lit2uHweXoOL6i7OWdCVonw4l4PzfS7I8?=
 =?iso-8859-1?Q?t7VEwFugqYzfl9HTIGt+zJETJPERgfsOZhKYb/ZV+ykH9Arq0/1fBz867/?=
 =?iso-8859-1?Q?5yXJkkGE2K4PX+fGjGabQotvQxmn3UCrZm0Eltg+Y48u8d8F/Ms8lKqytk?=
 =?iso-8859-1?Q?coR0C7Nk/MdC4VHGkHk2S6FssxqouUwQ+BL9LfXutDe2MLMkr8qGJIDjoC?=
 =?iso-8859-1?Q?UIty/B17fBUyPDNC1W5Bcf+jpdQEpQ8=3D?=
X-Exchange-RoutingPolicyChecked: MMW9emNAxtRD6VKLGShFJTSnw99VPOVsKqxdxUKOMDSVe9ID7zAsEhxF4EkGcgIRpB4oVfj5t6MPoh6YDCynYtdO/YSEB91lQztjJVH22B4k8rjgc+3gIuZTDFtbHQlg75pz5JMak/n3t4d38TlicyXCBdImGvIHwaQc0eOZRdjA+xa+DZ5f+az4d+iNUEZqyJGceBsRKUu6FMqPLxE8NDQlAIcAzJHe9PG5p1Q1HQZEw09LSVgzLbha3QsKEo8VrJC33ZVkwS6QWIIlHfgZ4bjS62gsaaOXi1K4frLXI+UQTaiklEnOcmSDaEmKM5cA/1sdn5NDSw5HPD61e5gkpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 111d07ba-100c-44bc-f07c-08dedfbaa7bf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 02:09:50.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg1jeF/xkbFhtNOsUhSASWPmkDqE6zhu8NqQ1IeIG87JLD4Wq73mtC03KTxJ98Jpi68Oewz1BGZ9P7K1VYbFlj6/dQUp+Yq+a6olc+Ykug0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF382351574
X-OriginatorOrg: intel.com

On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fail to update their `interleave_granularity` software state to the computed value, causing downstream decoders to inherit incorrect granularity and fail validation upon reboot.

Same NO as in v1[1]  and I don't see a way to graciously alert you to this
in the code. Gratuitously updating the field is not the right thing to
do.


[1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
No. A downstream decoder can't inherit an unecodable value into a failing
check. A >16K granularity only appears below a wide interleave, and
everything below that inherits an equal-or-larger value that an interleaving
decoder couldn't encode. So every descendant is necessarily passthrough and
never validates granularity. There is no path where updating the F_AUTO
value would prevent a failure because the failure cannot happen.



> --
> 
> --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Allow passthrough decoders with >16K granularity
> 
> This commit allows passthrough decoders beneath wide parent interleaves
> to have a granularity exceeding 16K by programming a don't-care value
> in hardware for non-interleaving decoders.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b4..d164662668c19 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> >  		return;
> > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > -		      "invalid interleave_granularity: %d\n",
> > -		      cxld->interleave_granularity))
> > +
> > +	/*
> > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > +	 * don't-care value instead of validating the stored granularity.
> > +	 */
> > +	if (cxld->interleave_ways == 1)
> > +		eig = 0;
> > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > +			   "invalid interleave_granularity: %d\n",
> > +			   cxld->interleave_granularity))
> >  		return;
> >  
> >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> 
> [ ... ]
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b64..5a443551288c4 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	 * Interleave granularity is a multiple of @parent_port granularity.
> >  	 * Multiplier is the parent port interleave ways.
> >  	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s: invalid granularity calculation (%d * %d)\n",
> > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > -		return rc;
> > -	}
> > +	ig = parent_ig * parent_iw;
> >  
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > +	/*
> > +	 * Keep the computed granularity for descendant setup. Only
> > +	 * interleaving decoders require an encodable granularity.
> > +	 */
> > +	if (iw > 1) {
> > +		rc = granularity_to_eig(ig, &eig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: invalid granularity calculation (%d * %d)\n",
> > +				dev_name(&parent_port->dev), parent_ig,
> > +				parent_iw);
> > +			return rc;
> > +		}
> >  	}
> >  
> >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> 
> [Severity: High]
> Does this code break region auto-discovery on reboot for topologies
> containing a passthrough decoder?
> 
> When cxld_set_interleave() configures a passthrough decoder, it now sets
> eig = 0 (a don't-care value) in the hardware.
> 
> Upon reboot, reading this hardware state will initialize the decoder's
> software interleave_granularity to a stale value.
> 
> During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
> path skips validating the granularity for passthrough decoders (iw == 1),
> but it appears to be missing an update to correct the software state:
> 
> 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 		if (cxld->interleave_ways != iw ||
> 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> 			...
> 			return -ENXIO;
> 		}
> 		/* missing update: cxld->interleave_granularity = ig; */
> 	}
> 
> If cxld->interleave_granularity is not updated to the computed ig here, won't
> any interleaving descendants read the stale parent_ig, compute a mismatched
> expected granularity, and fail validation?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783795720.git.alison.schofield@intel.com?part=1
