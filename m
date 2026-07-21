Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1943CB8E6
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598952; cv=fail; b=lRpq5ra8m/DLjDH78bPIdq5gmMPmOFvMWmCwmuTUIaEQ3XeAZ0igImVfSvyAnZ4W9UaUz/hZFzFQ4Cel0Umep07NUgNi5Gr/kYPEnMuO1b1HMStBls/FY1TflWOxHvi5pY4XqPMJvlMX9oD2X+d2nTj1xGFDzEobnzDzsqJh3Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598952; c=relaxed/simple;
	bh=2MQM/1H1CJ0tI1pHgJdKGHIaHGWvROEV7ECEi5xBTGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIGWVBegX1etS85XomhFLHRG2TfT7sATnIJg/B0EQRasG7x7LG1NBvQaC5ww86nuJplrS5SNIzPHckfD+NMH1uHx+aZWooYeUwWhWF0UhjWy4h5yllOJJrikxSf945C4uFc/EKHY0uRSEtrpyRgoea1ZE4e3FKE1VGkGOqSX4no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is4XC7aV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is4XC7aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784598951; x=1816134951;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2MQM/1H1CJ0tI1pHgJdKGHIaHGWvROEV7ECEi5xBTGo=;
  b=is4XC7aVx4FGLsTQ6p4IF/iuAN4c+GKLsqtBjZO1imtjp8YIh/yEm97N
   SRhPrnch/hiSsSnbga/vLGA86D73LApLB20HpbasIFkLkUYQgSaR8BENP
   VBeS5UID5oWM/CzH/EnQMXDTFoyTXdCrBWG2Nd85SWOjTjPDq1Co+jyqW
   d/63Nd9mchc4hAupWBjizXBTCKUqSWjlHcUkE0g/29XTgAbUsVSrntS7N
   7XhP00OCHXEFSCzHc/oSG7EObh2vS4/iHc/8/597OJ2D0H1biNofWC+Eg
   Eegewrbv0qeeEWg4sMtEeqGrjGHCrBjzjVou9/e8FQpGmR6w50ZiYPqxO
   A==;
X-CSE-ConnectionGUID: MTYt8CYOSqqACh+Y1HPdtQ==
X-CSE-MsgGUID: zlwDJnjAROiJ9/Tp/z8BuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85283916"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85283916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:55:50 -0700
X-CSE-ConnectionGUID: KqhmsMLgTwuDBROVfB0WYA==
X-CSE-MsgGUID: hRHhzx3ISU22R6CMnuEGvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261406344"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:55:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 18:55:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 18:55:49 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 18:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/lmGf/mgTo0TMt/bdS7zvoIYvO3lt9ubZ04VRZf3W8C6TVJgZHx+GZDX1UfI3tibfSI7lQ4nWzpKREsL33ZL2M9WhkaQVsEUpmcFGu2Sw51zFYdMkijRl9oeMFydTH88Kbljvp0cVKF5fSEkmg9+TB0u/5Q4vTLOVzIFCK38HRR9QgQAnRTVHAQGSF1P0dBWPWzbRWD888eTKCpRoy3KnBjl9QBzg7kymzs77Hd62/dVGuGvlHrogJ/CwT3sHFTi7OzNDQWVba1ZLOq4Dt7QRrGTRxa3WC0QxAOVzSDRsZME137qCLKMUjC/AiJBXra++ULoXQCC3Q7tYtNkz9PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGMe/SMn/DF9GcI6z4iDKtPQx2wHVCj7R/RmSWk6+SE=;
 b=E/vyNhGPIl2c4tRnnVhWguBIPbLsYZtCJA7dRVwSOMbUamzRQCvn/PLb87q4C0dtQQV0/+QL2G/r+iR6yFGTNFiOVvIZqIbXpph67lL/ANK+vCsDkjd7hKs8nA/F943cD+Q7y8HFDj4XfXuS5ex9slQshvodakAloboWiX3uzYxKci5NG5RsweWFKpDGEP7SCT4Xj6Eeglqv6MWe4al3MnCPNpVv3SyJ7U3g5LxtahXlyioupahgJPYLTOOJ2lOL/iqEjepo/Wk6FyKtkHStEZ044dCsLJkAB0h0+rJ0Kj4uB7jtzmwhhUPsO9PREKoILtjO0HBvda2lkKdLmvRe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 01:55:45 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 01:55:45 +0000
Date: Mon, 20 Jul 2026 18:55:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v3 3/3] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Message-ID: <al7RmZti3STwPkrb@aschofie-mobl2.lan>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <d75080ecb9fad922623781e9e354baab05842c2a.1784322343.git.alison.schofield@intel.com>
 <0967bc78-226d-47c2-a8f6-577577976c89@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0967bc78-226d-47c2-a8f6-577577976c89@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e60488-0f74-4291-19b0-08dee6cb2d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: G1J4wnrLK5Q4Jf9BUcN4SCEWEq0f2QTlFoAgbO3jdaUkjifA6S9FK7cetkmT5qh9iMAk9KKOB8X44qkNSjgtkqhHuRZrQcWOczRdlSKVzTIzbmi2n7CXWyLAViLWedzTSE/8gR7ryvkDBlnD7xRecUN2p7XDY5gCFIps4ZXaQjmjis4y60dGnic7hy24zB41CE8ftZqTxRq0btWHhqmhnKB0HVMbLKVTADiemkiVAxf5+OZalO6z3iBvIW19Yp3xTa2NHV+TGfiiUWXB1PsX9CkgYqL3ubAJ668/2LCSoFXTAdFsbHovrFfXJAZlBCofXMMBJjzQUnKSYlklbSVCb4QATOgMjk0EcgGOILXU9za8wvXu1eilqeMbLSSR1ok23yA8p4h4UMCc5pZgxJ5Pz48Dtqr+upQyS1qXFrcr2xXix8GB4D+YzhuSOll8S5+GnEqrFIJWCTVHpEthtmIRndS+BhGn9D4tXK2LyBvmrsnT3UDoIuLbrx/IsTI0VPslzn6ZNG8hJfhVKO4kMfAMr0ZIgn1gjl7aZSRiSncIVDrKOe8L5PQK0TIkGpNiq/9KUrWW8X1MW5wm05f+seyFyRUvynq3a1NK9jcXx7NOyNd58pBhiS3x6igeMaEs7s8wO1XElcpcc7fR5oJYjwPtm+cIffdEa8Zc7SFOhsV0TQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dicDMxVFcvVWpCQ05DZ2Jjb3hSclJ5NTltbWVYaVRYR0w0ZytGMGlLMEsw?=
 =?utf-8?B?MTEzZUs4emt3ZE1RVTc4OG9MRkY5emNybG92RGVpdmliZC9ObEp6c004elQz?=
 =?utf-8?B?U3g4azJ4UGIwV0huanYxejVkTjhicmRZU3h4Z1RqaHdMbHZBNmFrRXdldzdC?=
 =?utf-8?B?anZGMEk4U3dweThjK2c0Tmh0blBob2N2RTNrUnFwNk9wT09ocUVSa2RxMXRP?=
 =?utf-8?B?SytMQVpOZGg2TFRUR2dXejFKeG9XV1BMNUxyS256MENUTlJvTEx2RVlYa1k3?=
 =?utf-8?B?TTBDU1U1SjNObE1PSkw1YXdacldhYWJVY2ZCcEd0ZjhQZHp2ZkZEV3lVajk2?=
 =?utf-8?B?blBxbnBUdzR4VlgxWGFveVlrZkhtRjZpc2lIN0Rkb2ZsMkgrRGh1MGdIbnMx?=
 =?utf-8?B?YWx2dnhOV1VVMjNHc3AwVERQaWZhNzBPdjkveXVIRDEzNXRHbUIzc1JDV0dK?=
 =?utf-8?B?VWVJbVBUdVpzZ05NcDMrV2JyU3JKOTlWUEU5dDNSM0luSVhsbUlQb0s0TFAz?=
 =?utf-8?B?TkxXbitzemNjOUlUcS9uYWpXeVdFTnE0akVyOGpRc0wwNUxIUloxcEdVMUJJ?=
 =?utf-8?B?NnFjeEZJZnNJQllaWnBrNUtIY0pnbFEydkw0Ulh6Y2ZCOVE4dC9MdE5CNWxr?=
 =?utf-8?B?UzRVNk1QS0RpZjlPb0t6YlJJY25kMEhxT2xIVDA5amc3S0R2aG45bkZ1K3Vv?=
 =?utf-8?B?ODF3aCtWdENzQWpMZS9yTW5jVVQ2ckVlVTFpN25TMnROZmIzdmJHNDFmeFZN?=
 =?utf-8?B?aGp0UFUwL0ZKZ1FTVG8ycFo0aW8wWVlDamhtUTliSVF1cHhTSTZyNWhmOUZN?=
 =?utf-8?B?QWJTaUdvRWtnQTJqQlM0QnV5dTNTNTJRMDQ3Z0ZVdXVTaWFXMEplbThWanhS?=
 =?utf-8?B?L1hKd2dJdTVya1RDdlJ4WHdHMTNvb0hZTGVRU3dGUllpUUxjSVo4YW9WSS95?=
 =?utf-8?B?ZXY0VmlSU2pjcXNsV1VZdi9XaVFRNTZxcmh5N1RzMFNMb0UzTEVwV1UvaEtq?=
 =?utf-8?B?d2NaeHQ4ZUFQSjBoNnR3L01nUzdsY1laRXRVTHBacnhnK2pMdDl4SWFsUlNJ?=
 =?utf-8?B?T3A4VGZtbFpUUkdKV2hsYTAxakxwMnMvOFBld1NJS3JmM0lCcjZWUFVsZGw1?=
 =?utf-8?B?ZHRoZW5wWTU0L0VibGdSb3RGK21CamNSV1BzekxiWlNLY2d5N1dWWDRvUXF3?=
 =?utf-8?B?eVpIWjI5UitKeXhZU1hqRWJvbzZkbDB3SXZ1TGFySVdjRllZbmpRSGRvdXNK?=
 =?utf-8?B?c3lucFdQWVRaZ21UTGZwQklVV2tRTEVERzZLL0pNWFhzY05RUDQ5N0xKWGwy?=
 =?utf-8?B?MHpTL2xTdXFscU1HU3BKaFpGd1RIWnJnMkwyN1VoMEpsOE5NcGptOWdub2U3?=
 =?utf-8?B?aklLYzFHWnRReDdZTExGcmp4eEUzMExxOXBPWFh2L0p5WHE5dDFmNFZYMFFR?=
 =?utf-8?B?ajdLa1Q4T0dyTWkybUVFZ1A5ckJmTXBBb1B1YjBzbDdoSFBDbWkwbS81NkZa?=
 =?utf-8?B?UFFkYWNCQVdKRW1KVXJEL3A3Ny9CZ1R4WjFoQTBOd3dvQ2ZNZVlSeTYxTm8y?=
 =?utf-8?B?cGFqbTFqUkpEZlN0S3k5WldyT0tSMXY3R2NSVlNmdlJHZHYwT28wMDl5NGtE?=
 =?utf-8?B?Z2R2OEg5ZWxyUCsvTGJUbzlaVVBSUmFhbDFOS0s2ZGtaQndMeDFSNlBMMWho?=
 =?utf-8?B?VXM0aXpVQ2tXVitUc1VzVHVVZkd6L0tYQ1NtTS9ndUtrRlBGVDVYd1F0NFdJ?=
 =?utf-8?B?MkdCYTg4aE9zWTFJWXU5QnA1cndINHcvaWRzd3RyTlY4VVRsdndYdm1QWDhL?=
 =?utf-8?B?WUFremRDVTJYOWUrSmxINWlnWUpXeTZucnJWcElPcWdoYWpkOU1aUXkvTEo4?=
 =?utf-8?B?cEFIVWMxZHdreFpWek44M3h2R3FuL0tQUSsvR2FzZDlJdFBmTUZBV0FWd3JO?=
 =?utf-8?B?OFlFa2VIcGtrZkk1OXY0cnR3SkJpZGlZNTVsTHdVMElHdTdtemozK05PdDY5?=
 =?utf-8?B?dUZ3dW9vYjFLd3puTXphQzdPdVF5bFB4bTF4bFBFbmlZalo2ZENzNDh5dy8r?=
 =?utf-8?B?U05DdDBlWkxWZFlhWFFJei9TbXRhdWU5ZElmdzBQWnp4bU9IWVhGYVFwbm1X?=
 =?utf-8?B?YnZuc3VQUzNzT29RZHhJaEN3M3lvUmFySlcvdWh0VzVwaGswWUpoMkZkRllh?=
 =?utf-8?B?WHhIcEpNbXpDNmlScWRadjFOK1UyWnJyZjRvOFIxZy9jZmtBV3R1d1MwZW1s?=
 =?utf-8?B?TDY4WmoxYUFFY0ZJalhkQmorYTBTV1JUMXlhZm10cjZwWk1aMC9pc1lveGN0?=
 =?utf-8?B?N1hXYlZTczJKcGNHcjN4WUd4a2tmZE51RFRuYkV1eTlCeXFjSEo0cVUvQUh5?=
 =?utf-8?Q?+hN3J+wKyAQaK6A8=3D?=
X-Exchange-RoutingPolicyChecked: dz3J6vaobKJwiBfy3eHmblNIljIvAJvat24mwNiMqSSa91Paa5QrxRLZBevcDif/AlHJ4YhxELqGCc75R5lz+iqnxBHvZr0pb1IHtU2kJeuFa1I36H4QZoJv/daEO7ddz6RNqxSlRIZ1IeVD5s6m96YW/M6+eu3nCZ1+axY7h8JX6Gsf4R4sZJNt1ySFgVGwdMT0/fUPRee5jIaiymWu+2tZtYavbnJMAzDLXgxJn2u+SjabKj4R7MZMlFXXRjPk60gVkOC91CXkvjnGLSx82nu7Lkd6UKbzOAJ/bhUa+30ILfJjG2DhBH7txsjAH+rAD6LmI5YjMUJFel3bmlLSww==
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e60488-0f74-4291-19b0-08dee6cb2d96
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 01:55:45.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fw4PhC2EIXs/OYzUb/Fc3Vfw2u+H8+Zc+8RXZXsCtOdh/8hgfDWe4PjPMKGKKrnH7odIXSkOwelX/z9QxpQvytSA07J+G0GI8Buc+ipKTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 02:14:30PM +0800, Li Ming wrote:
> 
> 在 2026/7/18 05:42, Alison Schofield 写道:
> > commit_end tracks the highest committed decoder on a port. It gets
> > advanced before decoder enumeration is complete, so a later failure
> > leaves it pointing at a decoder that was never added. The next probe
> > then rejects decoder0 as out of order and enumeration fails.
> > 
> > Reset commit_end to the none committed baseline once the decoders are
> > torn down, so a subsequent probe rebuilds it from scratch. Register the
> > reset before the decoders are added so that on unwind it runs after
> > every decoder has been unregistered. This prevents commit_end from
> > dropping below the highest committed decoder still registered and
> > exposing an inconsistent value to a concurrent reader.
> > 
> > Protect the commit_end advance in the DVSEC emulation path against
> > concurrent readers, matching the register-programmed path.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
> >   1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 4aaadb842d90..6dc6e53c28c6 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -955,7 +955,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
> >   	 * change the range registers at run time.
> >   	 */
> >   	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> > -	port->commit_end = cxld->id;
> > +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> > +		port->commit_end = cxld->id;
> >   	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
> >   	if (rc) {
> > @@ -1183,18 +1184,34 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
> >    * @cxlhdm: Structure to populate with HDM capabilities
> >    * @info: cached DVSEC range register info
> >    */
> > +static void cxl_reset_commit_end(void *data)
> > +{
> > +	struct cxl_port *port = data;
> > +
> > +	guard(rwsem_write)(&cxl_rwsem.region);
> > +	port->commit_end = -1;
> > +}
> > +
> >   static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >   				       struct cxl_endpoint_dvsec_info *info)
> >   {
> >   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> >   	struct cxl_port *port = cxlhdm->port;
> > -	int i;
> >   	u64 dpa_base = 0;
> > +	int i, rc;
> >   	cxl_settle_decoders(cxlhdm);
> > +	/*
> > +	 * Reset commit_end after all decoders have been torn down so a
> > +	 * subsequent probe rebuilds it from scratch.
> > +	 */
> > +	rc = devm_add_action_or_reset(&port->dev, cxl_reset_commit_end, port);
> > +	if (rc)
> > +		return rc;
> 
> Seems like devm_add_action() is enough here. port->commit_end is -1 already.

Agree. The reset on fail would only write -1 over -1.
Changed in v4. Please take a look.

-- Alison

