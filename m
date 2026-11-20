Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795206782;
	b=I4M6pGy0FUAl+ycNLEtmQqg39un6tZCAR5HnTbGGbPSkEXMFhDM5QoChB7Ro9eEPrBC3
	 TTqA6LlfY1hB8+CXAzHD+PKWZIowcTM4Y+K4y45WOBqhIQz1OJlF7N58hQ7fifhBqq5/S
	 Xt3V6EFwK3/W7NVC3z6egRaS63se1RfOP4vOHOBQErSbrjAD2/OCaXhjxMfWnU8gj/Ou9
	 TlSqnPe5vgrV8Xoeagjv4blNjTcNpfi+jth6fEmpVvHxONAlz7B+5i9Kj+0nwjuNd5vTi
	 d/Yg8b95G7SNqW4XfNgW3nCCK8qCCGvDVwlfcYYjKYLVI8ASc3mUzjszWK7WpKG5kQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206782;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=t3zjK1DTcUm62vbAc+2WR8mi5HlRaxF4V5xtbrBohtE=;
	b=U1YJdJdqCMWtWYdUn+gPQzPd7qjwj4/w3Kz7LVgrow2c4bTMPvpMpebQU3gctjMVupyp
	 G5VautYghnkg4sWHjjOB6rr3Eo7oAVoxMDKv0BBYORoy6xqTladW96BZVe0df3TIpoaol
	 Dv9bKa1V2vaGnQLc9Pa0ky8W95ApJd/F2KfFllxmCgsUxIJ6eOWflRrTbf0uFmyQ0A6Lk
	 Iq/LOnnh78PJ/JV7f/61u/AxDBjdt0lN3OnkjwhLsAvqspEkE/7sAll82atOXAzb8nJfU
	 kdHPo9YvwFrZmt0TZlRjyW4XGlrYKh40TDmE/DyPhG8/oRzkKY97gJZxhCjWEW/9l6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0JZeJV4;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="MW5Rb/DW";
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893A606A6DF
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 20:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D893A606A6DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0JZeJV4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=MW5Rb/DW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795206775; x=1826742775;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IorSinN7+UtE3A2ptskAqTxQ7ax9+DJ0aM/BsnpvOPo=;
  b=j0JZeJV4HmoaEDgjpSb3lG5C9oygICHaGG2PUMfl1j/Z/jHcziAxRiXV
   AJ6JCDy2NlAoH1L/W4EYw8pYV4M2VX1WETfHBlSGVi7ttB0fsRRN5SBIY
   yUh37Q7KQk1i4+KbxPlnbZv88DD9rwkarG1BsdcTAVmAzPBJtAtqEPJys
   b2FoXsrMoDMlcPMF6JiUT63eAVh7wAwNpyJ15v1RQFYtTkxZKnT4/ZVLH
   5Jw1Z1+JUJe5pOcJWKuJ5RUVQhvvjxVo/JNzdthXIl4VqCLDv0MgU+JaE
   ADyUcrfqXSim33DQjXztSsEXZz0Ozc4paJMDGQuXaTFUUxykGItpxY449
   A==;
X-CSE-ConnectionGUID: adqh6o9OT6uJd7sNG55dOQ==
X-CSE-MsgGUID: wak1/gnXTNu4nDuCQ7kAoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4088444"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4088444"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 12:32:55 -0800
X-CSE-ConnectionGUID: MURlvnDhQTqe2U//giqWBQ==
X-CSE-MsgGUID: kyl5B3wuRMiD46Jeo/w3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="12778456"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 12:32:54 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 12:32:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 12:32:53 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 12:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4EyuUurFqIxrGFKCv772K9Qzu3XYYF7Wr53f4PrRyvjSzQ+dkoUh3Kv/mQzIfJwc7SLQ1J2BxzNueePDMhnsRuFonmhVA/dADLYY4zJVe2/m+0ZXVGnYWpXjF6xG0ZohjKCbFjRz0OusyrUzSUtrNfqrJHdDDxmDisvafcBdv1j6L4/V8rLl7kzVmRV+wT+n6oBFGqxx/xynShMpNt4EMV22AkTQPRU3AhuQDxIIQbApIMyYtVZ4utQEUl7h21+Oe3H8zDth6vlfkjOUNf+cKzbYIp1UvLnZDO867ovTB/80Aia8AxDwh+2kXh8sYrQRAA+w5qt/fm1MrHrHdfDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+6y37rDLIzJn/pSgK+R2DQgYCyUSlsRK5FRuRtXEAA=;
 b=kOJh/TU+IDzsGLIafOMaIUVbTGTsxgJlU/gh0+KKjIGstKJC29i6JRgEtO1aBCNXE9DwjKqtV7evtEP6pXzRrMGd7C0u0rCu/G3vd34oEcnA50na5H39Q5dfyePtX7ho+7lqd3LoE+sXwG+Hv5wf0pFWDTW3OiUAmMoCmrDreiBsNhPbO9zu8ILoS5YGYnMEsA7IMblmtgyfjqzOGk7Adu4Wp/CZvUIOumpJUPzcIQb/xMoBX5aaHZa9KVwkGxUC6lJhh5nkfr+CldzITtBzNdUOMM3MExuR/kEeMXBRwbGQACirqZm8ZLzZLgjL0T7iTr5S1bN/btV14Bwzgh3Bug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+6y37rDLIzJn/pSgK+R2DQgYCyUSlsRK5FRuRtXEAA=;
 b=MW5Rb/DWYVnAFRj80Ef+Kzr8BdjZkdrWz9Qy3Hjp7FNJaMwCiypX8bvzw273PB5EoDYPOQzvuW8Hc0clmyv+b30X2y+6VTKRuvuA5Y9BZqYLnmgLfUP0uMYBtLj25SRPzK6LcKbDkK32GFuvKlMRAvd95LLzRQjDox94GdBvf4g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 20:32:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 20:32:43 +0000
Date: Fri, 20 Nov 2026 12:32:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Keep a decoder staged when its auto attach
 fails
Message-ID: <awCuZ099GHIdR1gY@aschofie-mobl2.lan>
References: <20261120181228.1466310-1-dave.jiang@intel.com>
 <sashiko-outbox-225857@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-225857@kernel.org>
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5898d7d7-43a5-4b82-6330-08df47456d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261026121527099003|10067099003|4143699003|11063799006|260925021911599003|56012099006|260925022911599003|260925021311599003|261022105027099003|261026140227099003|261009223027099003|261021121427099003|261022075727099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ScyKzHep8w3GgI6Ii7u0fs6R6XhUwXEjxX03bb94dZMY6lnIxomjutrR9mBE6LDAcWTlqnj8He30dRg7SVUJAABME+mUj3ZkwRz+Craksjd/0DDKA8SXcSS6Nqm4WIE0ZMmYx6J3wqte1eRbNZxvSNw4ZtLY4qO1NnBMfoSZm7yM+u6L/Ja0kkLPSkL9832L/UxxwS1OdfXQZtMUY36AK+bFLOKQC8IUN3QNlfHP9ey4QyIrsxZkiSf5yQNUStaU0p+Pvp68bqLPoGSOBbwpqmSHdd9QoKNNhWdxp/bhZwy+OjE/ivP4vmMjyRv4Xd53E3yes3E7hJeGOVv5pgs7sX1eYP6qM9oo7jAG2pFTgZJkgVPC6IJuwY6RwnlJJM83oNau+MpkltUWK2384EqsKOOjcrLkBEskxN7rPvhwTKENyVEK4eDfGUMPtoKPxDLaxCXyUw/ls6ZNAqlrYehC04ZMBBhpfooF/ruYFEJYADTyrInmX/XnFEp/cFK9SZtJkFfY0pVIi0Z33tdyf/poknz0awnwq5uCK7LzMWeZOyoof9TMmnrw6MyPUfdvbWIk7ujXDdpNGfDp25uTUlUdfp85GIh6Rw3xxXl9fQTQOFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(10067099003)(4143699003)(11063799006)(260925021911599003)(56012099006)(260925022911599003)(260925021311599003)(261022105027099003)(261026140227099003)(261009223027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UmoDs3BXjzmFlUtqUr1+NOmNrKdJRfP8zcsbwgxM1tL6yYO7/eNLVniFJ3?=
 =?iso-8859-1?Q?mk3YiWsI+L0YELqKP9OMJScYqYBPZvRZBIdUhYNl8nCxjRUy6/lOlC7+zG?=
 =?iso-8859-1?Q?NiQRNEgqeobUPm3gFYMDgqXENw75pSoluF2sjXe1jhQTVPe/GythbE3e7A?=
 =?iso-8859-1?Q?UQSwuTjUIQAczlHUjpjBKVMgqPWKkkkdf1GraQd6THnxRyxNgW34fZUml4?=
 =?iso-8859-1?Q?WqwoUzCAqn6oVY/Rpt+MiZrTEsDdlY3MR9wxSsfskmU3BAGkcZqVOt0Bfd?=
 =?iso-8859-1?Q?adv16F6TF5wZ2kVgGKiMa6n5dgvmz9rHC0yA8LIoOviiwtLTU383rwpNne?=
 =?iso-8859-1?Q?JhvKbnQbJG+XXWboXuxu/2pioZDjM4K/LZybGENIGYuOoMIPcQ1eCknyN3?=
 =?iso-8859-1?Q?1g6I7eHHLcTzfUtHq+PnlWFLaFgEFyl9lC1u1nVf9Cbod/YvhViNFMfCpv?=
 =?iso-8859-1?Q?QLgnKvWPONCGlioP6G23fLPsMNKoFnqzeDEtzaeLHh7awWJ0UgjVMp+lb/?=
 =?iso-8859-1?Q?UzBFXPLNDYQXp16eEaPJ/XrjPqi/RttoyZ6katBQA7JqrK3b8bl5qpiJUQ?=
 =?iso-8859-1?Q?cgtuo3reHSpE/9lzxoMDuxLtVjkoyjThm3KHCDtBGJjlv/a+ut5Qw7uMn5?=
 =?iso-8859-1?Q?eIJRlLJ/F2wVnOi3aSktCyv7zm1CZ/jDVke0tvzydqsN0vp5dcJPVzXHPF?=
 =?iso-8859-1?Q?0NwjClutfDsa8pw8Bn43uAqXEHVV2C15Wsa3GFR+JjYm/k3B7Xwy0QS4Jz?=
 =?iso-8859-1?Q?xVcAx4GMaXO509dvJfy2FHTz53wSGKhtasK1gAN+vKjKr/iwlZUbQzHiPf?=
 =?iso-8859-1?Q?TaH80rO8qSDQKZBx5LtZ3rFGWFvH92w7NRG4lB3pVSex0JPBqdOOShVt1V?=
 =?iso-8859-1?Q?nOBa4PxcjoBeHl2NplPVymaI+UudpZ54YuSvGd/DrlL2ZNQeNY35nVIfmN?=
 =?iso-8859-1?Q?ZGvU1Lv3a0y9MPDBtr0evHojrx14kT95+jgowsENuqgnBLFxQIdonjnj52?=
 =?iso-8859-1?Q?MCR9rTXG11XFi9Z7cneUUxtoiDZtKstVDj6XH0v8tQVxqnyRNM66ynnror?=
 =?iso-8859-1?Q?WckUVIW34qOAq+i34Zn6M1qczCDVwnwTSyJOfH1Xd5nXXvjJPF3h07KP3G?=
 =?iso-8859-1?Q?531MhsFRCHE6Psc6Yvj7E3/wbyhgSScHOJ0Bf2IDVTpjUL8zNp9zqkXwIW?=
 =?iso-8859-1?Q?6c7OBm2605taU+kBkoFIROX3+yzdFflvsG+Y0V4n5comi8LIJlxh0e3PBz?=
 =?iso-8859-1?Q?0IamlmiS1opt8r8CdLQuL7YKvIS25x3ziqTd5/p71NySiHE5LRJyASnr/o?=
 =?iso-8859-1?Q?TWij/SuJ5a1NCNENJ07TSUgid5gASCSB/B6YvtVKNpXoK/94RsXb3NVFbx?=
 =?iso-8859-1?Q?U1HKDkUnuYQlPwQz5w9NR/TrLk9dIWQM1bKw0IyyJALVPEhWAZGwsHoMWU?=
 =?iso-8859-1?Q?AMiRvtVBIa9ykC8FRKMAue8DyqqkpVPp4xFJ9xMapuZoo4pKTmuXx/w83H?=
 =?iso-8859-1?Q?lmKmpndsrRpx+2U/c+kCjC6yXiU9085Jj//+GGOUm0FAtAzSlJK0Qq3wZN?=
 =?iso-8859-1?Q?u+47AFme7Brh3bPmT0uFhAgFeJUZ7q40DXtqrfzDNIGlqwCpVaXlewjotu?=
 =?iso-8859-1?Q?FvuzHdzVvNMeNYwHvxHzqYgxXYt1vArDRAxklHhHLO3mueeyamDCXKWFk2?=
 =?iso-8859-1?Q?0oLuKK8XVXl95D2b6yBKkQScLuH8YlNy9AHoDpRyx2eAHqAFWTW4AxIGTJ?=
 =?iso-8859-1?Q?hPI2LfQOU/YKFAKWC4yZsx+OM6e9oMjFnVeBvYuvHBm9055p51pW3Zd05b?=
 =?iso-8859-1?Q?aGS301n9gPzJtE5x9oYk+7NkfY/COGs=3D?=
X-Exchange-RoutingPolicyChecked: PNJnA2EJ+bIeqczNLmTM685/+D6lXDE8RciokP2CDWYMScFfDiYCVj+U26kvCNYgGbBwkYrWSm5YDkVP/wQ2Vp0vMkoyMHfxG8S6df2StMOFgPIpqWAL0iKoP8w54gLOloa+O4TQApbQm/y/LIEr1tAGyEjKFaqBFCQVN+yBzzkmUtqT+Lp1ohSAOHaHAEu7emiQSAUiqMuH/j+GP6zYdKtAmuFT2Q91+V2reN2buKj7giacvuox6Vfav/NnQ8zs5tR50OKc0WTgM9v/WMEgyUK5bP7icc85RXbrxIrtk7qk+G25RJDxijpFL1C6LkHYXY00frnHwNDdzDc4NBvOVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5898d7d7-43a5-4b82-6330-08df47456d98
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 20:32:42.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P3gxGsSXUelkaYdt+FX+AIv9VhqCKXCrcrYVgaG9qyD2Tx5+Zpyp8E3E2yZD9ZH3T6xO0n8Dx31C6D4OI0CV5gzhw7dzzbZ6FIDmiTEZ+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
X-OriginatorOrg: intel.com

On Fri, Nov 20, 2026 at 06:39:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] cxl/region: duplicate target attach corrupts region refs in
>   cxl_region_attach() [1]
> --

This is true, yet we already have a fix for it in cxl/fixes:

cxl/region: Reject a repeat write of an endpoint decoder to targetN
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=fixes&id=b8183f9259b55fd79ecd0f2039bb4e9393eac936

with that in place this complaint goes away.

-- Alison

> 
> commit bb73ffca81dd406b180098a77a7d18645c37f8a1
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> cxl/region: Keep a decoder staged when its auto attach fails
> 
> This commit restores an endpoint decoder's state to
> CXL_DECODER_STATE_AUTO_STAGED if cxl_region_attach_position() fails and
> unwinds its region attachment.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index a048bd5c06cb6..f1083976592f9 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1830,6 +1830,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
> >  	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
> >  	     iter = to_cxl_port(iter->dev.parent))
> >  		cxl_port_detach_region(iter, cxlr, cxled);
> > +
> > +	/*
> > +	 * Attaching at the endpoint port moved a staged decoder to AUTO, and
> > +	 * the unwind above cleared its region again. It is still listed as a
> > +	 * target, so keep it staged for cxl_cancel_auto_attach() to find.
> > +	 */
> > +	if (cxled->state == CXL_DECODER_STATE_AUTO && !cxled->cxld.region)
> > +		cxled->state = CXL_DECODER_STATE_AUTO_STAGED;
> >  	return rc;
> >  }
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but can a duplicate write to
> a targetN sysfs attribute cause this unwind loop to detach an already
> attached target [1]?
> 
> In cxl_region_validate_position(), if p->targets[pos] == cxled, it returns
> 0:
> 
> drivers/cxl/core/region.c:cxl_region_validate_position() {
>     ...
> 	if (p->targets[pos] == cxled)
> 		return 0;
>     ...
> }
> 
> cxl_region_attach() treats that 0 return as success and calls
> cxl_region_attach_position() a second time for the same decoder instead of
> returning early.  When configuring a manual region with interleave_ways >= 2,
> attaching succeeds again at the endpoint port (incrementing nr_eps to 2)
> and then fails at the parent port (for example with -EBUSY in
> cxl_rr_ep_add() because cxled is already in cxl_rr->endpoints).
> 
> The err unwind in cxl_region_attach_position() then detaches cxled across
> all ports up to the root and frees the ancestor ports' cxl_region_ref while
> p->targets[pos] remains set.  Once the remaining targets are attached,
> cxl_port_setup_targets() gets NULL from cxl_rr_load() on the ancestor port
> and dereferences cxl_rr->decoder.
> 
> [1] https://sashiko.dev/#/bug/linux-bc3dac83-96b6-4b99-8e2f-b2f4ad93b98b
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261120181228.1466310-1-dave.jiang@intel.com?part=1
> 
