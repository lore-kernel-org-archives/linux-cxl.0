Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB252D052
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631787; cv=fail; b=Tco2qiR8h2BJaloZDy99j1TptQ2EKvWGbp8pDP2GaeTjpgUEwXAksqxe7FtuCFVD04jgNNfxVm9wqDoAH7VQQmMXwJyuvuWvmLUg4PW626QB7HgTlLUUTMFtLprci8r9JN7p+SUPttiVPtyRCS226unrwEU1dngpJQ8px7IQE6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631787; c=relaxed/simple;
	bh=EJ0U7OPUkUHPcf+CuJwTxtHFlcCCTVT00OkzEHIbW2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jsb3z2C0M4t7pj9Az7zmSXyssHC4xtFZDG3/xQfIJLgxRfs2xJ8t4qkYpbuWQw1H6XnykPaIpZm1EZGXtRHhV3De0P4VYCtt6K424evEsAVp1uG1KVedsioDKwPpSBB6UbFl08mUoRCP2N4rxqsCpHv2gzUzmRGfxpIe0Noe3cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENs8TUWs; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENs8TUWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631786; x=1784167786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EJ0U7OPUkUHPcf+CuJwTxtHFlcCCTVT00OkzEHIbW2A=;
  b=ENs8TUWsQ8woW1Wk4bDACHa4g9U+sVDVCE0Qhlq3MTIzL+XC4q3p86CV
   M3hTno0j0I4IEO/YKNDmWE5xTUsiNncFIejIehuFD5iWN2MsX9hxAdVd1
   7we6+yYqqObBq+6OzQoAlgupBHi7KkwQ2qOU2zTyu3ehW7FCs7DA3nsf1
   Bdd1biuYl4WkI3ed/Q+6cv/WXe9dWrfMGe/tDdgfy/u48vZ6oYEHKia9+
   yRNcy0EhX4MszBjHhvG2L+s9AYmE+Yb8J5XlRcVcP7/7xFfk7iyZef15A
   Qf/CVibym/9rTtFqNfVfmPs5S44Q/vf6OmgLqbCGzrG5HG/fY+7ZNevWa
   Q==;
X-CSE-ConnectionGUID: 2VFm6QcMQSqPwv4ZM1iNQQ==
X-CSE-MsgGUID: zlqJ79+UTlOWNn1fJdK8MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54958002"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54958002"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:09:45 -0700
X-CSE-ConnectionGUID: t52xku0zT+iyZ70SeB/x1Q==
X-CSE-MsgGUID: Wy4H9bbLT8WPlte5RV68Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157478704"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:09:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:09:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:09:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:09:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJwAlKFfnxslsGa2lMH7fK/+W9cZ65WCCJKn322kVK66Qz5ZC1bowaTjTaSWHijW3Uu8BSD3Tom1oCsYHD4qAgxlWD5v8kQbxEkhTmgQHCrHXMGx79QTYnxplNEJYsEChUwIfS/ovgsVwB9xXptUM6cfKkp5mF9bER8B/Y0LxirH/ENgzsHEMfc9Xmlb+F1EAdBDbjsOXu1rzXoX/0BJUFFBaOmID2NpMLwcYFCrrpKOjHgy7+/Vw6XY1Q7q/gNEInOi5pRgvxrYBEK6Zeb2b6oiOhxXDLPOnTUmfh5Y7EU7JOhqZO9b3UvKFSkajl/43juECKKTdB4R8Eqyr34q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS3Z6AaQQ3FFZQguKeDlKaEC8omw7SJaq9oYFXXLFm8=;
 b=LkUoFbxBeai00p3Fg4GEifKpcOQiSLy5gawu18pfptQXXUPKZ+ePNj9UrwkxsVr4oPU5MQS1tHPQ2+HNrptT5lw35VC3Hr0nVK4LHliWDzcm3NOrgYhznDyiQQ/EbV2IOiL2F6mNJs++Bk6SPW0Z/GC1yFk9wN7P3ACdrKK7xkjxROhMug6mMEzmtyHAezKisLMdkFZ1bqZXIf1c8CKulWfFca21SOoH0/Jlk4NMxIUEH+gC59ei9/f0W9y/UWgJ90d2bG5Ftc6RKIdXlmfw9p4bnub7zIsLqQCdkNTjVwFjDWkDh4lpSO+0VqzZzkKjVT24HUqv0hBtMW5un3+kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:09:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:09:41 +0000
Date: Tue, 15 Jul 2025 19:09:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 10/10] cxl: Remove devm_cxl_port_enumerate_dports()
 that is no longer used
Message-ID: <aHcJ4nn89f8OEYu7@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-11-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-11-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: ac08d75d-001c-4fc3-fa2e-08ddc40dd354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tZtlMzyNRWcBIqlaNfjBWP7t176RJKlST3g0l6eOPzFI+cJrKV3je7+hAfv5?=
 =?us-ascii?Q?ogzDC/yx84dRsRnfoz785OVnbw7Q0QuSyHe6diXnoO3OeD+RRJysV+9fiJxo?=
 =?us-ascii?Q?GUcEZkmphYgRsvUxBgRSSrfty8I2UrOeRyRTF0wVfBmYPEByQvVNWQnUQQGB?=
 =?us-ascii?Q?0zUHb1RnwvHhJDiceRN7SIVlsbQtsvR74kqo487N3N8dvWW8j2lUCv+ITqqU?=
 =?us-ascii?Q?I/wPNQeL5xrZs97I/lnJgGverEI3rjF2dil4VIBLv+YsR9IVn56FOGdnkQuj?=
 =?us-ascii?Q?e3AnzS6TTfeIdnnvfr+NueSiU+C24+fOTekKqh8aj+eZdLrjn0tyiuCXPYPn?=
 =?us-ascii?Q?3xef9wD9k68NyzUXzmJvcyDv5TSihi4KxLcQK75qT7zb617n5MVxnfn5SV7h?=
 =?us-ascii?Q?lRQjhTpawmXxz4O1bR+4LrW9YeCbTR2gJzYKMWdT4pLsTMx1bviYcj/GpC0C?=
 =?us-ascii?Q?K7f2Q+z/xP1R8O/PjPJKSEknKCWuGyIfsc1Wfqh39SCqCIjvZp+T3logsiVs?=
 =?us-ascii?Q?klAEMLtbLfv0rT3mfBFsrxbDcaUyJee2IXGtkTv+1JjrisPvRZ3iFP19MUGa?=
 =?us-ascii?Q?kvQIJh+Rx8IsnPXRpgh1/VemDMKCYGpsABO00A+YjrQcQ6GUB2t3MwJ5lLD1?=
 =?us-ascii?Q?MRdWzpvvjv4jGavhht30WPkMgUoqR84WNgNnIF/bG6tl8IWF4sh863y5tkNA?=
 =?us-ascii?Q?K8x0nHGjILHhsXLvV2FV4Suiwd2dZBl+AIpYOkkZqdo01LwxY/4witdrRxCm?=
 =?us-ascii?Q?69vz9leGM9oDM9UYyUcUMVA+NNHWlyvbu/ZU3agK4FJpWQqqYRWCWb8rolVF?=
 =?us-ascii?Q?OBfx+EkZLOi4Pzb+REnerwdxcbDln1CaIjCP94p4T8a+9rGXytBUEqYdRSh+?=
 =?us-ascii?Q?6J/aUuH3JIp2lM5rNGgbm1NEHgXwiFJ/jrrdoK8XXsYd2ziKlPE9RaBuDxLP?=
 =?us-ascii?Q?51rkcV+I85z/u7NQJFV4wDfpEvWaXfcgjo0gGXDwmNxeva6QYiwCid/9gk8D?=
 =?us-ascii?Q?LDyf37oF5OF+Yl9Fzf2Guy7Byyqs/2b3DXRSQQpfsypaQ6e3tMkgyja6/AGJ?=
 =?us-ascii?Q?0T+7cxntLxLGfU29wvjgy7XoBrZYJhnklly8tybt2LdHdtioa99YdqTfyiL3?=
 =?us-ascii?Q?flZRbYCNQQNrK1f3vvOBvNTFuRcqrHxx+n95+/cg6SBPaBv35R7YB/ywjS9z?=
 =?us-ascii?Q?0mrpq+6V0uMw/J6K0hicLfJO9gDaJZHi2h3zP9kL+fyxajpMA399ExfhL43U?=
 =?us-ascii?Q?JAMpmx3nJtEWY5RbEgi+CABwkP9p5dEAzlktyqIFmQlmQUlH80L1QWH/w5Yd?=
 =?us-ascii?Q?fNwYcotOxq6PY4H5+rcRDOcCJTWDbEc6PN55NIpzAzKknfYT2mJfCS/GuBI5?=
 =?us-ascii?Q?497y23Di6SpiMSgjFAfWQwFLIsB+m+MaC5Tqr+YEmSCtX/0CSrlEKm1lJ88i?=
 =?us-ascii?Q?YJywoIEzX/Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixl/84HqNlMGAsH35gOkfAXhc0qeeoioYQ4e8sVv8wqOGA7bWmC2FeuavsJv?=
 =?us-ascii?Q?P8pTfUu+PwOg+Vjl2qV8YJD4X9FyIIm4Gndk06AMS+T25fceRQcProp8bB5Z?=
 =?us-ascii?Q?f4QnLgPtoWDelvjZ/uI3T1YeOvNAB1NhlrxDCJ1Yac1yk51qI+CO4Zdav0ht?=
 =?us-ascii?Q?ks5CRvxc9wdF+vWBEtO5S3cm/2fbRYr6DBMnubVr8WMt0CkQl3sE4EpJtqP1?=
 =?us-ascii?Q?vESHgWFPxlvz/99zpWouO2R/+9okdPa4zbb9+rXsABiiGRQws07YnJpgCgbp?=
 =?us-ascii?Q?shAlP9wxNA7TSun3R9wW9hnCGy2N51odf6ejrEQcoQkfRm9sEe0IMAuS+f13?=
 =?us-ascii?Q?0yHpppgDVOrbkkG/mcD/vE8nFw7f3x2IkgeQj3osTIbP46ga2H8m5rJAypbZ?=
 =?us-ascii?Q?V/ZmD6+pNWhpCQMxsVBfe4SUSNrON7e3Wq4zb8igT/6YArJ1frbD/uZ+yTDm?=
 =?us-ascii?Q?Tari8DEyMs06Hd9ZBnq3GAo3jrzyLMWI4K8gB12e4fO/WJnVojmisCVNdXbV?=
 =?us-ascii?Q?UBEJr77fBWEyNZP9vbi6wz74s6LImLYx/kVHCB+E1bu4bJlBMEqMqtvvhZ2T?=
 =?us-ascii?Q?LJ3nUB6fnXNzw0Ri5KNwM8vCW9jInd2Ss+bxM44NAmH+weBWf7Vrw79+EzQB?=
 =?us-ascii?Q?Y0PvDP/1ESWahl/vULnWCt0a57NCQRZ18eP50TwEkFaq/qV1ZJyZiuvupkUz?=
 =?us-ascii?Q?Dqh366zPYuA8mTUXaQvgN1gx1omVeWr6eW9r/regCAtWdMedUfJN/QGbKe+T?=
 =?us-ascii?Q?hMG5Oe9T1msiCcJoSR+tn7rRUs3wIddImiQFLh9OsR64DZp0jazJx9DtTBr5?=
 =?us-ascii?Q?QmrtuUYeYEIygAyPhlLWHuevAWNGTWdH1nJKEvjbN7PYB9JqLqeHtazuxNEa?=
 =?us-ascii?Q?IqaDIs593W64fOGN2l7B8cGx1pkQAoOPKYDSaWyXW72vHGREQYMjrPMhSl12?=
 =?us-ascii?Q?+J31GvLkhCfcGa2qCrfEcWOzgOCqa6BvW3gPGuaBYOsFMYAG6G+yPaPieqCZ?=
 =?us-ascii?Q?B6Ti1/YkR0SWy3QIEYHzz2KpbXpG3LPGuJpv6wB76K2guUAlZtE64k6bP4tw?=
 =?us-ascii?Q?4LJrQKcUEnosJHbTEBH4YuVVwuxNqwylY/X5yFY9n78ZWI2K2k+BJ0CQbgFC?=
 =?us-ascii?Q?VROA1ozKinWN0mM784hKZsdiz4AQMIoLppcLRYsOrkjuXbb/BLZrcjZAnLrp?=
 =?us-ascii?Q?9cb7vbbFZ/p3Yfl8Cp1MDiPEcgufa4ukwBnNaPx34AMdK1FZkyWu76qLAB7j?=
 =?us-ascii?Q?FTZGOW4nYiBoRmhIsVoXAskAqxOTssV9yVWI8wip2+I1Wel+KZ2UgucrCu5p?=
 =?us-ascii?Q?XEr9FQcJQXAu3Ch+oqfCup9un5/vUseA9QUkKEbdB7rYWWvo5UOmk81gGmX+?=
 =?us-ascii?Q?egn724wnE89VXgjNDyCZgnx2T6OhLFsVfPcpZ6x3fBtEvks9GmGtM0OvVLUa?=
 =?us-ascii?Q?lEj++w70eGPlgqT6J+cH2CmuBxx3tb8e0BMGaeJ9XWIs7aO92QbBDvK270y1?=
 =?us-ascii?Q?ofmvn/tBRmMJhnqBf7olDeutM/LiiWN/O1fos4+A2ghznLGuLIZDVvjSPWBG?=
 =?us-ascii?Q?081SPXdRBxfk9TmvMGgNXpPE5YIyOpqI7DOrKic14U3g8/TddDlTEyy/qZxo?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac08d75d-001c-4fc3-fa2e-08ddc40dd354
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:09:41.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYvKfud+4Ix8xzKYkiM9vxk4AkEOs7S/db+lB2TH+AP/4Uup4v7qxA4cDzGMMgAy4Bd15OjEOdoHv6pMCAk8Fok5wRJIgQMvO4GDxBbIXnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:27PM -0700, Dave Jiang wrote:
> Delete function devm_cxl_port_enumerate_dports() which is no longer being
> used anywhere. Also remove cxl_test support.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

