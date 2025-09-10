Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994B1E5219
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470780; cv=fail; b=ZFvnJZzHh/VaznlLkdHKTakWkHb3XYT6kMTHpucCJgE6ZmbcoLkFjAFqWV1GDWtzKtvYMvbeLxeYqjqS+npTioXrk/5cOgnVH92RXdIN22qydEiUfpboyVLEtg4VebqkXHVXg4n3LWTWnrdUFWqAy5yKOohRvh3SJBVOL48xOPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470780; c=relaxed/simple;
	bh=sxWsUTmlehUrwPV0iwKcwSr7fYytw7yRAgljrzSONKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HCB7XsVqkrvUKsR6Q5GpxlceoSrqvmZzEiV1FIi2EjdfG9PoAp5Gn+wpufIJ8KUQ5t8MywB5Dgc3Ag/ueCo1bDsaRoT8XFb77eUL0xJBdY6Vadg0b7PkYjNgL8tnHUf2qmG4R0FWGX9QTFShYQ6G5Q5FzjcN92F9A2+EUn2lBlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlwqPoKU; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlwqPoKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757470779; x=1789006779;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sxWsUTmlehUrwPV0iwKcwSr7fYytw7yRAgljrzSONKI=;
  b=JlwqPoKUB5YZhTb/ksWfR6GLB8nmdI34x0Xa/4bUu9hPsMdurYI5AlbM
   6GYqATqinIn2tv4qQ7FFiW4Y3VVaxwbGm4NGVZ3XiL1fQ0kFvMGWnHwWH
   xRnwjjHryX+nsms13EtXZ5jK8fJ5UFSytotYSg627msUoxMfBfLuAVIMT
   OMaRAGMc8yOsxCEVgh3vzn0yBGAPpGYJ5rjTL//urXG7MgjaqTiicQIvh
   NIYLkgXshISQNo2neNG7e/aPN6nrhjUbqWhta5vLVYOcEy3wyAfGhc207
   9k4nep+vlwvhD4W+RcHmfsZaYOIvsCu5/9PmjP6OTmEUnFWzaV+ZtIeEZ
   A==;
X-CSE-ConnectionGUID: Lg/V/mn2Q2KIcbt2eYmRFQ==
X-CSE-MsgGUID: j8HlWu7hTHuPxd6Cw5V5DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70387408"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="70387408"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 19:19:38 -0700
X-CSE-ConnectionGUID: 2BUruUEYTHazGmJczwahrw==
X-CSE-MsgGUID: wfSwHQ3ZTr2ve0WW6wqc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="173644002"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 19:19:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 19:19:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 19:19:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 19:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO4UTZFdaFOS6oURfbVVYgCHxX7qP0Q7vWcZhakOMPHcJysT2rhAnx0/h7oB07hq9D40uN9cTeHC1XDHfT5dOulDu+5oQuSVUWeuUpgMDbU7aaCiomrS6HNBQm7ICtaVaDeSu7w4CiK83te+I+sLKwSZmjolKZJK81PJiRcE9v9SrKG2/BOyCs9qhK+ia7ZOGGYU3/M90qbXEMAYSD/Ii8bJxq+32b8wWExwIOnvFurBmMpRi+atrXpXXRniUSWyagWT8SCAeZ3jvU8Sb57Fsf468y6Edlp9NZPI+v08eTmNepisndOp7c4wuLepL64LAiP6/90XYVjg22U/02H0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxWsUTmlehUrwPV0iwKcwSr7fYytw7yRAgljrzSONKI=;
 b=poJVvyhYgCHJuj5YoNWaFPE4+9BCinZx5BCngNDx3yeUFK79H1MUK6VF19Qun6o4873MsLVFJF8w/D+OWzbcDKfkzIo9/YAyA4B4ljWNE3/ZoVL8UvO7yYIQIANQ6zrgLNpe4Zk5PHAFHxA3siuxa/rm3pfqEkaulE1px3hLzk7Fh6IQIYYidWSr0H6wXI8l+jzPQZA2D2M1sQkzFZPlGBcUd0vCclXzj6f6t2VZF+UN/gonvPcG2pykQ/bAXRssBIO1ZxGzdOkaok8iGBm16HjEMu8OaA8CmF0haiVV7PeNDxyVGOXtqSRhElBGuqsbeivrh8fFCTsNKQ2/7rsAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 02:19:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 02:19:33 +0000
Date: Tue, 9 Sep 2025 19:19:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 05/10] cxl/test: Refactor decoder setup to reduce
 cxl_test burden
Message-ID: <aMDgLSx4nGFMrX-f@aschofie-mobl2.lan>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-6-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: dfaf6ab3-a4da-491a-175c-08ddf0107af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RVoRxJIGE6ee9/sFeboW5krE7DRWB1+abIsG13ShPvN/cDV0EhR8RJBKmaQC?=
 =?us-ascii?Q?po9UBXzW7A5ppoW7QSREWP6WSgqx9dVo9tljRdegNKf1GfMUlds4iKh7leHL?=
 =?us-ascii?Q?QC7GDRGKNdbprN1jN+Tmx+C0qan/vwQJE23r2+xUR/SgXgSuZtVEkMKm0bKM?=
 =?us-ascii?Q?0+WiTqM5w4KUjqjo1G17tIj6sWew6xTKW4aZljyAGyYcZP0a/nCicUBspv4g?=
 =?us-ascii?Q?e2sGOPGqjHLP/TXMWh9fLk8Zo/9DpiIM/1J1uJQeInNSrEXt+qR81FpWwVxk?=
 =?us-ascii?Q?cnIIUbSpJR092O7NYx7YsRo9ZZH2kmdaa3lcEkvSYNqaUO2NBtOP0CUtTcjK?=
 =?us-ascii?Q?hAxM3dRl52u1iOKHfhML1ypq0PzD6q9WhSW+/Tvxdr3GLKBU0YbDdQhof7Dq?=
 =?us-ascii?Q?/2jwG6KdofcXBis1Xhfm7JkbTrvXKJOnPx4Fzxj739M0HuCB4+jztUI1Jqjy?=
 =?us-ascii?Q?iG3wdE2IqORxZqRFbDIndfoTum1cvRRbhE/nssrIgFkptWByGP4WQxmuReZp?=
 =?us-ascii?Q?IzS+S/yWKGh+pH9bBcbw4FfQwz/nkfYuCfBFgVjSGoeN0yalQP/aiEzBKEDd?=
 =?us-ascii?Q?QIoSvPEJkLVM129gFSzg4WdNqqXvEAytk/SUDWFswc+XCeZhHPClHap7yEVE?=
 =?us-ascii?Q?PPhk3NqPRturK8p5fyD1B3Irq9oDmRSpbS1LO0YFDgN+HbG506zFnWf565gd?=
 =?us-ascii?Q?VPEcUUrxdWCWT3TPUPsZ0ttvApLQs6dw2OlsH4EZkoPMo/CtJV25V/UVvBo/?=
 =?us-ascii?Q?GyE73C8s9EbkljnCkRfvtdeV2CinVdqkTzfUEUZ05hxLofmvlNynazTPamuf?=
 =?us-ascii?Q?7MFUDVnSqKWg8wWxKDrPkn6mQyCSENNCk5QiIGomnrcynG4T2Ty1vnLhEuFG?=
 =?us-ascii?Q?B3hGXE4F+Os8i9bHrhp1/bBG66Tq6xHavYTPpKxFpF0tQ9uwMzumIEDmL9py?=
 =?us-ascii?Q?Ic+tgbdH4ikNSYyZrDMZ1YugzZr9kJMuIDw8RSFpj/CeMPf+3k6gyoCnc0SZ?=
 =?us-ascii?Q?rHCy59tpWWN6XwMntUNbzdEoSawr6neUoWxb8OLtzcmye9iehOyh4LRZF6Xt?=
 =?us-ascii?Q?ntQ2PU3da1Pt/xmhydkH6Gj24HA/CY8ZlsVnkHBGjFoyPYRgp2O/UOFPpAMP?=
 =?us-ascii?Q?pssXxsn7f1yQaCaYguDUHSY5+OhYLIkWQnk45kIrqdLPxkIUh4FuX83rISRs?=
 =?us-ascii?Q?zJW82VA4uaO1mzmHhfkZPOJPjjKZHTPU3DfOGqYsNQDugUe8epEcZuFkev2P?=
 =?us-ascii?Q?j8jyfryzwA+gRUhCSt2A/nEj5oaicJYgmkx+7B8CVnG9evO8b677yV0IHeF/?=
 =?us-ascii?Q?qnRcszqCOaAp66JEQiEP6uvKjs7MgF9En58xRsWP7SCl7kb/ntM3bLFcda44?=
 =?us-ascii?Q?pJeG2Ui55OXUsa/5d+ewul28F296iTrUSBhnzLnw5lqCjGDifz0Iz5Aiw6ts?=
 =?us-ascii?Q?JxqvlZ7elm0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQ8MwBFgu8NQe7am8ZA9ZtH5g+5McTe74ARAQeH7nb4v9NGajtmY5deFZDIj?=
 =?us-ascii?Q?n8EX3wmbhhyZ6pxIT4Z/fquArXN1Ux4oK9N5Wx7e5sYQSCkflyDIyTCEETUv?=
 =?us-ascii?Q?V2S2UBTTl5TQbFNZPOUmfDn8sGHpzonV2Jaxk7ZiAGIiz8sPvrupbGuwLTHq?=
 =?us-ascii?Q?t7ZQkz8wut9Vwr52vqiCm695BBN71ROQP1Z3lvXc1W7KscKybqDGwOrKvzxi?=
 =?us-ascii?Q?ooiEobgp1i+7L0UN/mFJ5I0HmRfOYnQOlLms7VOvEaChKCG4w9W3Py1NiVbx?=
 =?us-ascii?Q?m7im0Bwdo07+nR5ejep/niPU3fe+RditabjTOKPXk3zDs7vlSWUVo9I1//im?=
 =?us-ascii?Q?R5SI8JRbXeXIYvij07QoG0bt32fhyQFfiYq8XZvzYRu7SJ7frPI2DblBSthw?=
 =?us-ascii?Q?FNa2CVlakGfk3ymnhVyaTM+B38UQUGmCrmgVPxZQr7Lz7QpX4Ezo2k/9IXDL?=
 =?us-ascii?Q?/OwG56l0LSrlJgZWwJc2WCwQYNF5UDn+WKnvZcus+omYcumqiEGVlQUPXLOr?=
 =?us-ascii?Q?ePj5KYMiVYr5GbRL6rNESCSBWorLipMV3nP2xmkbFF1a4ZqoPbp9w3bn429g?=
 =?us-ascii?Q?KZtp94cXj6eUSIsIhfcw5H6q3XFG5uBXFn6Jm8NtGdHT7PIsHo8B+b0LNxzJ?=
 =?us-ascii?Q?rEPUacIBnInzqTMb3oR/pYbQDCbS9Pji28RLBcmuDN9k9aXwzVOq/i7oN9Eu?=
 =?us-ascii?Q?wAwdNyMLh85JuSBAOeYcRcUrR9COKKL77lStw+5hzsGmiVBx8ustWFp3Ts8Z?=
 =?us-ascii?Q?B13lkRsOSmgCAXl6J6cCZoNPBdsCEWKL7CSLFt5g3XquejJ64qTZDOsAfi0x?=
 =?us-ascii?Q?h9esGgeqAgtSPZGJHKg8HRMH65GCoPbyoSah/BvrMpcHT3SnH+A/1uC/xgw8?=
 =?us-ascii?Q?DA6bb4KKJUgxGR7vQ3VtX5USR0iX5hl99LruzOI8kpBcDtpODgqcmd5/DrNw?=
 =?us-ascii?Q?w4hjgBAxU87wsWyvMfQHLQdyraJRXsHjrP8JFp5XQmXF49u6VyX8cC+qhU2+?=
 =?us-ascii?Q?wK259hv1I8Rc5qT9ZypsDA+ylKR+lpMpAttCJnAMl8Ai5OfXMUomHOVBaiCK?=
 =?us-ascii?Q?oeAk5RrFEoN7/+GXRkgI4jG5B5wl18ccsZh0qDeXEzjLRHY0vGLIQPkQpfvv?=
 =?us-ascii?Q?FJAHLi983xMx8D2fhZ4iUbCrNb1aD1F2b3CddBU+j2vn0jy5wgx6CHMB8Lqd?=
 =?us-ascii?Q?YD1SExd+r00wXJuAQdWPGRiFWq7EfT8H8QVRRGJ27WoDZsUp02UtFBh7DsbG?=
 =?us-ascii?Q?fWltcSZFTIu+QOdQC7CQNMyQd61fhjKXCCwo90USI5KAuHrWysmgaOJF+rUC?=
 =?us-ascii?Q?GNVOqinwERiCyp0T6JDRcJwv44Z03kFyjMkhrLyYSevdT4Jz3YDE78vITWcs?=
 =?us-ascii?Q?u51uvhcPl2MC0bskXjbB8Ro5iuLcZML5L8YR74iLTw1YCMgu3NyjEzTw3B5w?=
 =?us-ascii?Q?X5tZONL5gePA65Kl4eLZ22w3GpZOOkYgDh3lDky8s4ani85FSWT6h0cQoU0c?=
 =?us-ascii?Q?U1VsNWKqqIso6lAyyzXsfKR85M96qomG/ApTPaN9aSCzg/JGMWVqn4GhLnV5?=
 =?us-ascii?Q?ToCvBYAUu0QM0aHj5T5GIlAxqW4e8PzNwe9mLvWWtzY0rPIKAku1U7mC16Op?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaf6ab3-a4da-491a-175c-08ddf0107af4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 02:19:33.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Aavk69EeG2ld7JMt+CIjPuipBjT1Xot49GH9ECDWUIZGcd2VZprnoq24Uk+LCo0HtkqsblRHEdcWpxi9cY6KVEI0Kx2tVQxclVkKWsotdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 11:09:23AM -0700, Dave Jiang wrote:
> Group the decoder setup code in switch and endpoint port probe into a
> single function for each to reduce the number of functions to be mocked
> in cxl_test. Introduce devm_cxl_switch_port_decoders_setup() and
> devm_cxl_endpoint_decoders_setup(). These two functions will be mocked
> instead with some functions optimized out since the mock version does
> not do anything. Remove devm_cxl_setup_hdm(),
> devm_cxl_add_passthrough_decoder(), and devm_cxl_enumerate_decoders() in
> cxl_test mock code. In turn, mock_cxl_add_passthrough_decoder() can be
> removed since cxl_test does not setup passthrough decoders.
> __wrap_cxl_hdm_decode_init() and __wrap_cxl_dvsec_rr_decode() can be
> removed as well since they only return 0 when called.

Nice refactor!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


