Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950C366824;
	Tue, 10 Mar 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183232; cv=fail; b=GaAM76EJuWuzefr105eoFgJB8Mz0YsHBh++iGzD+Ziol0BdJVqkcSxkE8sDilFN4eqaY7sNGE1A5hy1OOL0rjGNf14V/P8VoC4q224YoDt9zzALBAz7KxdBfAXx+w5orsTwsA3C3cy9OTFz3d8KXp4qBusGtEFaL3aMl5+DMVBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183232; c=relaxed/simple;
	bh=FF7/lFFmvldBV4iXyjnss26ESXtc8WKUT67eQDcFRIw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ccIRBNykKbPdnBbcTrXq0YVvOltaN6octywlu/eRNmlatPdI8hj02oQWZJ8J5gHIer8l/9D0R1+m9s8jUpNZkG18QltMnbTG9jQk3QU4srFnxOfGh2/UO9mgHzakKQ10urnGkPqt0Bq7aJxsUXZwH04UD1znNHnuuKQ2FLHZe6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4DsAJ94; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4DsAJ94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773183232; x=1804719232;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=FF7/lFFmvldBV4iXyjnss26ESXtc8WKUT67eQDcFRIw=;
  b=B4DsAJ94ZW6vqvSL240I7w6+8uL0sWGH8E5KwDiEMpQCT9ZgEC9AY0w1
   wFRE7jJXVYDyy56eyizsFsn4HteYo5Bd9SmmmubfEe+4E2+04ktilOaJr
   Q5ifHXM8Qtc0keODz0CD1uMIbwz5DY098jFNozVJZ9z+3Xo80JkkK/DK2
   KRoD/IoxtE0Ne4QIdo3UG6Sm72R7unaB8eeSTH+BAPPqV5kgrrJaEiPOD
   jCZX384/TcKdvhFaybedctwOox5Iwfk6kxBugMuj8V2wCYzL9wSSYHcWo
   U54uzTn88g3c/JpxitcFXV5MEz+4TbpEuxQHSah+ZIuE8ToJtymiivoIS
   g==;
X-CSE-ConnectionGUID: 8F4jmWPGTnaRgtt61n35Mg==
X-CSE-MsgGUID: JUtPRowUSwqRkh1Hl6G9zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74362972"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74362972"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:53:51 -0700
X-CSE-ConnectionGUID: MY2JF/4FQK2S7C3Bv1ss6g==
X-CSE-MsgGUID: sbZSrkrRSYqv7DqmBqkvUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219386680"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:53:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 15:53:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 15:53:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 15:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtZjXvYrhtExNAn+t6Pi1rEQ14HqWWQXAZGZYSk+cjk1VH95nxwT9HZ6rBAsexbjagjJdGwJETnNIZX0V4ITS2VIU5MX9ZpMGwzCFm0hpaTOLHL0w2lBDKLGWn+9mY5A7VYHcfHtPgV1XRfvqabferIvmvWxZd+W2cEcb+F+CPWBaw7f5c42xlBXDaMAt7jpexjA/2pMSCwN0YQZkrXnDxJ6Us9sFoGOW4AITzGkTCy/QKqnzgb0HonTkVri7QME/CaBpORGlCmW8Hx24pJgbS/IuvnfldikgUhSwDsfXMaPSLEh5UGYx5D42CFw2E3rKRrNhapUsprPwZM4spHWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q34hvXddaMXJ4F1IFvih2fkv00E1XThM2mt/uGOuzcg=;
 b=RFwzTRXOnwNwrBVUsAiAMRuvG+UL8RVngHobwJ/jnVm/9I5/FqJFvm8dq6DjrLllixMqeioY4LSqMwSRwkkLSZP9bZ5ATo4AKQvj81LUXAvyzSNUTxYc9jnlQEYDdggCL5BYyuNPgEl10w31DFpDxrHKa+lW+ta9mDTQ0AkkTgQWmbwIw9vWmCIBM4f2jPkaS6YAQbj0tXG+nZH6KBYeYThfOni+UvZ/vV9xGnfV5chuFMUDmay0WcH4/5tde0YlQcERegg8746Dhj9d/V5858nLoxRzlMZeivEaG/jTWdV5fj7RC0QwoNAarq65ypiDTbsXxpo5MOlD9UZeEKrozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 22:53:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 22:53:45 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 15:53:44 -0700
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
CC: <daveti@purdue.edu>, Sungwoo Kim <iam@sung-woo.kim>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Message-ID: <69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch>
In-Reply-To: <20260308185958.2453707-2-iam@sung-woo.kim>
References: <20260308185958.2453707-2-iam@sung-woo.kim>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ced0c21-91a0-4df5-f87a-08de7ef7e297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: oI1pSXYIfg34r+78bUjT8yM4c5PxdnY6Wl5icFPdkvGNS1n46hvD7LifqfgJwTROVT4KG9v8Cc7zri4CB83TiHBIZGizaKRq+aUPyY65ATsA4V3ISRt16zGAySqU/rb4Ig7jATFKtLPgJ3oiQVXqPUbVB97sdfB+d4xyE92HptOYLv5YFw3UbeRZwDsdaoBqPGm+Ou4y+S23SAlZq0Pl37Q2/nCyU2x3e8P7VI1F0mdzqXfqGdeOklKPsUpt0rBcRJFDRNXWd5HpzTvXZMbA0ypU6eiPGtRkWKNCyj6VeCYM2oeRvwxuvtxDx10HnFnPrHzdXlSFIY7iUwJv+F4xHEiG3sSazYKM+uMIMO8VRz93TgT0ej/KsXmEa9ztHZ7uDsKefzBIHY8mfxctvvREfW7TqGjqiFSU78B3cGQ0EXKF7cWgdWAiHDOyA7GgFWcaqa2pWaRFi5mOujoRBczRPH1tP8yv7+6NbKy+oQYJLPq0MXbw+firnKULGov7ttvGU/kWgKsNX+6RBiAzK9QIgj0azQUcXLK8sn57v+50rTJaSu+sXrHbKZlB+uqCYwOQT2uYwqNasFuj1o0lwOeQCaNjdQs2xRR0ARh5YsCCMdPmfBakWCuei1AxoNNLTInl18yy2Sl+2T8RuhD/BC+qsjGLqjoDl2PgnhOZg9X6+H+l64mXRpd9lfXw+16YuKyA6sMEXI/B+6KID7XzBnP7C4w0q0IeR4MQPcaisw8xido=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHg1L2NzeUYwZUF0czBGTFNjciszTFpIMUhxN2hZV3NjbzhsRGRENGNkTTcx?=
 =?utf-8?B?dnRYYWlZN3NPeEpLSFhwZldHV0wyUW5yTnptQlZhU2FWYkovdENNaHZwZGFI?=
 =?utf-8?B?N1JjSWtMTGxoU2dJSHJFR0R4QmhQT2pITjlNam00T0U4akplYzVnQmpRcXNW?=
 =?utf-8?B?T1dEbS95dGVoMnZQRU9kdmNzL3dGeU8rS1ZKa0Q1dUI5L2MzS1hjbi9QNTdE?=
 =?utf-8?B?dERqQ0dSaUxkaS9MUlRNVEplWS9WQnBZYk9QT25JMW44VlhETkx5ZHVTWFpp?=
 =?utf-8?B?bUs0YlNueDVRZ3I0enpjb2NRV1pZeE9pdURERGdLeE90QlV5WkkwSnZwbVkx?=
 =?utf-8?B?NjBEVzRLem5jTzZJWWxVaEd5aDk3QWh1MGVSQVdnbjBETlVnY1lQYTl3UjlZ?=
 =?utf-8?B?dUFxZkNIOTkzdUhXVTczMHQ3RFJDOGFvY2ZZWXdQZTN4US82OE1rV3ZITXlp?=
 =?utf-8?B?M0ZhTENPbUlVV1ZIYTVMN1lJVmwvTjVpMks5bDBsbU9JVVBxa1JacXJRWEdL?=
 =?utf-8?B?TDBvd081YStVc1RETXlRK1E0SFF3OHgxQTdWdEEzWE5DT3BQUDZuYnBhWXVC?=
 =?utf-8?B?VEVmSStybWlqSWNqN25TRTRENEVmVUQ3OWcxcDE0ZEFRNmpxc2lIWmNsZ2cr?=
 =?utf-8?B?SHJWQ08zVEZBRHlETHo2bVAxVFJiUXQ3SEVTR3J2a0VZbExuMjh1b1docnZj?=
 =?utf-8?B?TEE5WTl3M0d2QnlmbkhWNmJJZC91MFRpUXYzTVlWaUwyekRHNVRjSkp6SDNm?=
 =?utf-8?B?N25zRkFTeVlsaTNMbjh4dnR3eXY0VjhyN1BxeVlSS2EzOEJveE91R1o3K3hP?=
 =?utf-8?B?cE96ODRwRUhHeENWeXhiU1pTdklMbXYxNG8wZUtiazlwSkNmS1FxajhoQ0hq?=
 =?utf-8?B?YW5HWGcrbVNsakVSdm90eDdLWkVLNTZlY1RoOUtObDVkT0FWbzVWaTlhRkxi?=
 =?utf-8?B?SStVRFJHOGdLRDdKejFjNkJ3WWlJa1dWK2JvMGlsaUdGUGZnZzY2QzlZUUw1?=
 =?utf-8?B?SkUrRVFLRExlM2lBVXdIdkZyWmRHUFZpUXgyY0g2T2tQYmR4dXFVN3IwbFpI?=
 =?utf-8?B?QlBuOFVlaDRoOE96UUU3aFFWMUJKcGFEWldlUHZteDVjT01ZMTdGSjB3RlJq?=
 =?utf-8?B?bXNVRFEvd0FvTU1vdk42R3g3a0ZGbTBhYURJb2lTR0hhQktRNmxCVy9aTjl2?=
 =?utf-8?B?MW1sUVkwcHRqcDdITTZreXp6MjZ1TERpdW9SYitjMktGbzREMUd2ZWNPR2wv?=
 =?utf-8?B?RXhXTW5pZkNJZDhwMTFoWEtwb2I2MG5hZ2VEcFBOZURwcjE1bjYreFZBaGZZ?=
 =?utf-8?B?RFo2VUxNcWxCTThJWWhXRDZkS1gzeU9yM0Y2VjZKQkNrbTlXanNPTzZiY2hT?=
 =?utf-8?B?RWtwUE1sUFh3d0twZ1N2cHRxNTBhVzcwbXFFUEE2Vll1T0Y5RTVPRzk1c3JN?=
 =?utf-8?B?SlJUcUhoa2JuSlJNLzZyM2pDMGF5QkozYWNDd2Y4di9sWVpZQXV4djJMM210?=
 =?utf-8?B?Y3IveUVQU2hnbGQ5VmhXR2tTZ3o1bU1va3M1aElMRWdKUXZwWHdnM2x5VUda?=
 =?utf-8?B?VkRzdmdSa2h6WVFLbTdTR3hxY3VQYVllVVpPZ3pYUFlCSHFNdDUxajdHUmZN?=
 =?utf-8?B?cytkSVp2cVRHc0FFaVBZb051QUo0WW95TjVtMEY1cDVCZjllVzlsSDhuTnF2?=
 =?utf-8?B?b0cvTHVRUFpWSkdHSThzNnVrdmFzdWFpa3VkR1NTa00rVVkzME1qM0h5dURk?=
 =?utf-8?B?SUR1UmhyNW1MR0h6ZHBZM3hOQlViZVFFcFdGWkpQVnVhTHNkWVBOZENYTVQy?=
 =?utf-8?B?UEFNcGJ2bUU5d014b3FmeFRkUHhIM2dTR2N6TDJ6R2hMNE5BRHBXMnlkY1Vz?=
 =?utf-8?B?TWo3WUE4cjBlOE5rZTU5YWdKZEQ5S1RMblVoMW9SM3NuUXlDdE45NEdhMTRB?=
 =?utf-8?B?WVU2VmszRlI0akFWdC91QW1vdDlDY0JyNGo0NzQ5QVJzeU8vZGlHbHdXb01U?=
 =?utf-8?B?ejAvU3RNSlg2QlV0MFFSUEN3N0x3QndnUVBrY21EVkwwOUVlcWVrdS9BT0ZS?=
 =?utf-8?B?ekx2MXkreGk0aGcwYVBqUGpFMFpZN2RETXBtZWpRZnVRbVVvRksvU1ZnUURG?=
 =?utf-8?B?SHJ5WXdmemV6bDduZStldGhXRHVaREMxVXBsZGpwU0taajl3MHQwNEN3blNp?=
 =?utf-8?B?djR4TXk5cjlCaWI3UWYzNlFiTkx1d29URlhXVjFOODVHaE5DQXB5ZXhYbTNO?=
 =?utf-8?B?bkdBbm12UlpPRWppcGpPK0JlZkF3d21yN044eVMzWXBQbk03aVcvaEozTy9W?=
 =?utf-8?B?V05vRHFYL0ZXdm5kdUFxcCtUZkhZYnl6dm9JcmdWVEhidksrdFRFQ3l0R3gr?=
 =?utf-8?Q?PLZP1Mgqva33sRUM=3D?=
X-Exchange-RoutingPolicyChecked: aQoPhTK4MxmUhnLqNZ2tC3aOTlxnWxD3piE3Rm/rrigfIc3BYKFqGQKrmWWodnsNJ5QV6+q2XFgxr96v8SUGWHZN38lG+poTJyu3Z/NmMkHNIkXLjM0BtrOqybG2fLB0kmbxO0P7D93Ax2Wlh9r0eMKcXtUKToQJL8MSnERxrrtciMaUXKftCMoKNsoUHvOlJ8SPHzTKMvLx/4esN8F554AF5s+AOmNXS+FvrlE8psL0c4MvUDOqSpKP6fOqbzifLvMbY2Xp98X6a8HdfFT8ajBDGjpx47cGDMBFgJuRkUBl0XNAC5hPLjQ9FYprIIlEmZvaA0LyaDd53akbjr7KWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ced0c21-91a0-4df5-f87a-08de7ef7e297
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 22:53:45.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK7LzjWuDk5P57FRYSoC654yCC10eKP33C0iEutUJWbhQ8aAKzSEvd4jJdWmHY3qcO8FFfAiYN7YQe7+Wr8ZKls+cV711Q6ZpHBv4QocVJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-OriginatorOrg: intel.com

Sungwoo Kim wrote:
> A race exists when two concurrent sysfs writes to delete_region specify
> the same region name. Both calls succeed in cxl_find_region_by_name()
> (which only does device_find_child_by_name and takes a reference), and
> both then proceed to call devm_release_action(). The first call atomically
> removes and releases the devres entry successfully. The second call finds
> no matching entry, causing devres_release() to return -ENOENT, which trips
> the WARN_ON.

Ugh, yes, good find.

I think I understand the pathology of how this happened. Touching devres
actions needs to happen under device lock or with the knowledge that the
device hosting the action is currently bound to a driver. The
port->uport_dev is known to be bound in this path because decoder
devices are only registered in the bound lifetime of ->uport_dev.

The device_lock() is not needed to make sure the release action can be
called, however, *some* synchronization is needed for racing requesters
as you found.

> Fix this by replacing devm_release_action() with devm_remove_action_nowarn()
> followed by a manual call to unregister_region(). devm_remove_action_nowarn()
> removes the devres tracking entry and returns an error code.

No, that is not an acceptable or comprehensive fix. A subsystem should
never try to double unregister a device. Keep in mind the decoder sysfs
stays alive while the devres_release_all() actions are running for
port->uport_dev.  As a result, yes, Davidlohr is right. You can
theoretically observe the unregister_region() release action firing
while delete_region_store() is running.

The only comprehensive fix I currently see to that problem is to indeed
get it back synchronized under the device lock. This prevents multiple
requesters from colliding, and from devres_release_all() deleting an
action that delete_region_store() already committed to handling.

This looks something like schedule the devres action to be released in
workqueue under guard(device)(&port->udev).

It is ugly, but it may be the case that this wants to synchronously
delete the region, and asynchronously cleanup the release action.

I.e. unregister_region() grows a new:

	if (!test_and_set_bit(CXL_REGION_F_DELETE, ...)

...flag to enforce only one path successfully deletes.
delete_region_store() calls unregister_region() directly. Then the
workqueue's job is to trigger the release action under the lock only if
port->uport_dev is still driver-attached by the time the workqueue runs.

In the meantime the workqueue needs to hold a reference on the region
device until it can observe the state of CXL_REGION_F_DELETE under the
device lock.

Otherwise I suspect if you put a device_lock() in delete_region_store()
it will deadlock.

> ------------[ cut here ]------------
> WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/devres.c:824 [inline], CPU#0: syz.1.12224/47589
> WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 drivers/base/devres.c:817, CPU#0: syz.1.12224/47589

For the next posting, these 2 lines are sufficient, no need for all the
extra detail of a full backtrace.
