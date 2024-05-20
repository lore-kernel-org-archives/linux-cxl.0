Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE245035;
	Mon, 20 May 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246847; cv=fail; b=JbTsUVQqsc/iOBYWgmSoVlhONwgolY/K3R4shK3rBMphFNln1LzQw51gFoJdFLXIxG7UYS9edkRaH7RNnBsqXg2tlMjXCR7eRC4KWyReb7+PsnmXw0qmmMJ5gKAJO8bUzIGfTap+eQvsNvmK70wLw9It/UAPZjX9a+4tKuKkzxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246847; c=relaxed/simple;
	bh=RJxis1sXDQYg4O+YsRjGE675RyFCP3bF926JkhdfxSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KHoyrYwSNmmGmhhDssN/PALx6MhY+QpEbovv5+2VpDiI1JRvzOisrrnfZDNUJxiqvNkflvymA9/k1Lp5DoBaaFs7ybGKhcyVduCArGvN8LE1Yb7ApJu2PVeskE8EAIUI8URtjNsmzrJqPyv+XmbuK5fbroI/MaNPoedHbIrrEuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wrw+6i0A; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wrw+6i0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716246846; x=1747782846;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RJxis1sXDQYg4O+YsRjGE675RyFCP3bF926JkhdfxSg=;
  b=Wrw+6i0Ah9/hsILPg6Q++LOs3CNStZLcxEjwxArwPhpT9q2qGG5Yrmt/
   dbHmGNNVDX2Wl323i2K6Vs0TshpQl60coNEuqp1hcCZDVB8NYAVONT4cB
   PmUQxOLJFdjZuIR1Punc0Rha/I5ZR4VhAFkLOhNAnEIQGQFJKqGpBRVnp
   SMNtH58Y6GO87mxYc0HcYldegn1aqt9z3SpcENaufiWCX1JZ0b2PgUBF2
   /g2K5U044WjH/WdpXPyre3uQo53cekt6WcMb7IxjL9UEP+QU3ZhaqGEjR
   TB9jhQk5ixkKri6IbXgIQ3CrbFj3U/6DuCJ7yP3sR4K2xVcEZlyGuV7m6
   g==;
X-CSE-ConnectionGUID: die0vRiOTwKNoNMEs0Butg==
X-CSE-MsgGUID: r5wR+l/9RYeAueEDqFXLkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="34924039"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="34924039"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 16:14:05 -0700
X-CSE-ConnectionGUID: gT8eFB5DSPS1JKggqVVIlw==
X-CSE-MsgGUID: l5sHGmvvSBG7Uirpoc0bTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32733328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 16:14:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 16:14:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 16:14:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 16:14:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 16:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjdnooZqrV210zYHa+74hWDCBbNc6TUTTerHtI2xldru7KVBl2hTTzPWyn4SMAfag15cm1A3idwbr57FBjm3vwRpk4xWv2ckc3H2KctaTqlK5qxP8mXLWJU4590k/b3JXxxZY6b0lO/9PBLvAvyMEd7Uq9H0y/ETS/yC2YO11mOE50aRSRwplY/+Hfr/+Q6L3/kYny5dnJIn+/7pGBV4R9fu9+XCGGDqSr/7gmHK6zxqJkXC4AGI3sRlhV8g3IxvkzLk/pEFPnsMZGgDVY15om0vOJtGhKfNaYDuCe8KbrJh84SQ3P73QpPiiwN+tD4ksPBp/auwzH7zt4oKUCNFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpA1hBNVOykD4VT2UxXogSxCKAMJ67peRB+kL+MXyIo=;
 b=jyRyDiSRMHA0KJOwwJMiJE1RgWJSyGozDe78Jm69150hXQ4+lAi9jGhfu5qRlyRaG6Hazmnf7ucnmqYPHYuPldKFNdHs34ZVwW64fJWtRNszc5TiR2O/9LMawR4zPmy9Las905NsLKMQkx3zQ4REd25pNzZNEn2MyPnmiGTx18nU+bp1Y6Kjnxh0SW9ICbx0CIhLCRB/e9QhpaGU8n9fktA5Dsp/aKbV31213x8HUHzcjlaByqQ/I1v1FpojA7zQukWoP+UUvh3uLLwDqggqT0+0AHn0XFsAM2O4b6RQNjvnZ6ML9e3lNIqZgtE0YNAVYFh1l2p2Y0nMEpl9ulyEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 23:14:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 23:14:00 +0000
Date: Mon, 20 May 2024 16:13:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <664bd935b9eb4_a02829444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
 <4446774.UPlyArG6xL@fdefranc-mobl3>
 <2114228.Jadu78ljVU@fdefranc-mobl3>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2114228.Jadu78ljVU@fdefranc-mobl3>
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3c4f2b-ce99-4acc-7c18-08dc7922881b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnZUZEFDOEdQdjgvVE1vWHJtT3B3U1hBZGtyczBiRE9DZ2xlaUpXUFUwanVC?=
 =?utf-8?B?QlNOeTFlRS9NUlg4TDR3UXk3VXhheVJ2NWMraHMzenNQVnJIZlFOZ3Y2ZUpW?=
 =?utf-8?B?Z0VNOU95RkVMQXJlODNrcytEVjhLcVBsQTFkYkNET0I2WUVNOVJRMEMvejJy?=
 =?utf-8?B?WkxyZnQ1UmNINWFNelNLK1pRNVFRYmxmbmF5aGt6aWgyWnBiTjhycVV3cExN?=
 =?utf-8?B?ZUFuRXFoYmJJRnF2R0RnMWxoTkNNWnQwWmVKUVBEK0tDeTVvTVIrY2V1YVRp?=
 =?utf-8?B?dEZkK2tIK1pvcHJFL1h2Z0ZtY2RxeHIwNldkWHEvdmRjMytpT0E3ejRWTUdk?=
 =?utf-8?B?ajFLengxODNvaGs4d0VpNWtaalNpVXpRYTQwS3FjWUVQbWZSY3pjZlNESUVV?=
 =?utf-8?B?KzB6eXR4N216RW1ZZGdyaHhUeFBzdWtRTFM2Y1gwVW9ia01nT0orZWgwRUcz?=
 =?utf-8?B?Wnp1dC9HUStjL3dENURpSnlzYktzcDdoOEhadkhnRGExV0paS205TGcvZ3oy?=
 =?utf-8?B?aUxTUWw3VFExcnB6dFpuMlZDQkw4MTA0K3FFMmp2eU1QN20yZVE5VXpMMGFn?=
 =?utf-8?B?czZ2eU05R3pDZ0NKNTlDRThVYXJ5ZGROcDUycDNWd2V1K0Jkb1VjalErOHBG?=
 =?utf-8?B?eVZLdHFrYTl6Q1BaY3d0eEJHZkF6TTdZZE5UbVpHNTBmY3hnTkhJNWpEZkxq?=
 =?utf-8?B?OEh2WlVYL0pEc0NkMVFvT1BSb0NRZU9OUlNibTUxYndLcWV3Tmx2VVA3enpn?=
 =?utf-8?B?aGVuSHZEWCtwSThtOVlZblJhQ2ptWW5qclJWZVhsZDYyd1ZqWWpuRjQ1TVFp?=
 =?utf-8?B?Szl5dnkwT0RLNEl2V1ZlZnJjOXpLb3dIOEJJeC8vQ3JKZko3MjRtLzA2TzJs?=
 =?utf-8?B?SVBDNHhnZlJiWUxnVlhDYytIcWU1aUVxV3VVSXo5WjdXbFBsS1QvQ0JucGFv?=
 =?utf-8?B?Qm1OdWU4L0szYUNsZS9qSkN2QVBBRWJ2b3RHZ09iK01jNjhjaFNFTUp6Y01W?=
 =?utf-8?B?TFM0QnR5KzRhT0FrSkpaOVFaMHh5ZCtVTnA1RE44dXlpb3VJbGFOYkNXNEp6?=
 =?utf-8?B?aE55TWNsV3Jxb3N6bW1pV2REVnc3VTZnUGlLSEptR005RC9nVElIWkZaWG5a?=
 =?utf-8?B?WTdCb1YxMWxJYkRkdHYrbWtFK3dhcUlmQ0wrcVlQQW13UWRIaHhpc0lFcUdI?=
 =?utf-8?B?OG1MRHBVdHd4WjFwbnZyTXRJMTZOV1o2VkxHUnpqTFJVbTBNd3hRWHRSeFc0?=
 =?utf-8?B?RDYyQjZKQTF6L090U2x4S1ZKKy9VQ3JsR0FCRDlnZHVCNjhyY3lxS09oUHc4?=
 =?utf-8?B?ejB0Z3pKdlhTYmJTb1N1TEw0cGc0TEJDcFZHdlNIKzVjUXNxUDdDTEMvY1dW?=
 =?utf-8?B?VkxUa0VLaVBkZG4xaEtzd0JtT2hHYjc4eSt2NEl3M2VmWW9kWEZUTEN4a0Rl?=
 =?utf-8?B?aHlNNk5PVFk0K09CdDJRdlFJcEZQQWNUd2tmTFpEMytTbnAzTDgyNTR3NVo1?=
 =?utf-8?B?SGgzYU9KMzIxV2g5QzBYcFNMRU5xNStiN1dNTk9JWUN2YmxacldSTE5TWDNl?=
 =?utf-8?B?WW1IMDlxWFpuOG9jVzBHL0tKZkxJYnJ1WE8yR3BzZ3FXM3VKZzUzalpVMy9W?=
 =?utf-8?B?c1V6UFJLcStOcUN4dEFuQUVNcFRqWnpVdkFXUXZJdDdMYnFaWFROb21QVVFa?=
 =?utf-8?B?SnJYQjcyQ25VREsxT0cxV3YxTTNEOWlpT0k5YldONzlHUEREMjYwK29BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdWczQzdlVVd1V6cnYyaVptQXFLRVFwNmJrd0pQOVFxWlNuN0lMRW1SOGV2?=
 =?utf-8?B?cTJqWjJmUGMwRzRLUmhYU1QyMFpZMEk4NWYrbzVCZjhGSEgvdW8xcmMraXkv?=
 =?utf-8?B?RTR4UzhkbUdmYzR4a0NuZGpOYnJNdmZCcEs2VlRZR3JKaklFWUhGUmtYQ05o?=
 =?utf-8?B?bmZGWU9XcTR6WGRjdnBVMHo2WHRjejZIdng1ekNuYzJEc0JpRlNZZVdwaGli?=
 =?utf-8?B?YXh2M3NXMzJmU2UxVk1RWTdvUVNTbUYrbFNETEZWY0p2MXo4KzdPclFWaC9M?=
 =?utf-8?B?aVJOdVg3SnRPVFlENnpLQVlRVTFvKzh0MWMza1g1WTdaUGp5c1JJRTJaRncz?=
 =?utf-8?B?dHR4bG5sazREaStxUnIrTFJ6UmRPMzNFMTJ1ZTVzRzIzUU5UUXJLa3RJdUtq?=
 =?utf-8?B?Smd5NWtWdGFTWk0yWC91UlUyUHVSSHFwY2xJSG1lbVM4d3lEMmsrUDljOXVm?=
 =?utf-8?B?Q21lRTdlQjdXeGpkUnZZRUxWNmdlWHplQ3RYeUVmbU11Z2FUN1pwZnVXNG5U?=
 =?utf-8?B?OFI0eGxIcUFRRlo2OXl6ZW1DQTlNZzFYQ3VjR3B2VitXblNaeXdVNUFrY1Uz?=
 =?utf-8?B?YzJ5QXJrRTdWNGlUMVI1WXBNUnlHVCsrOHg5aFlKeUFUa2E4NU13YS91OGUv?=
 =?utf-8?B?NWxJOWxGTDRta2p2UUNaNnJJUS9VTlo3aXlKMFFXeVVOM3I5TVJNUkU5Q0xP?=
 =?utf-8?B?MDhuYmV0T0xsSHhCWVE1QVdvRktDUXNMblF6Qkc2Mk9wbk4xZk9DdnVnUlJL?=
 =?utf-8?B?ekZSUWlha3AvbDRiQjdRRk1rajhNazhId05qQnh1R1I3NklTYlJud2VWaWE4?=
 =?utf-8?B?dDZ4c0VPMEwrL21UV1RyTWh5UzFWQUVaRHVCd1Z3WDVkOTF4Q3VKRkQxRHND?=
 =?utf-8?B?Wmd4ZnVoOWh3MUVDVGJ3QkRWNktndFczS0pobTBNTE1idWtGbW56NlJoQXE3?=
 =?utf-8?B?ZTdWWWxTelZTbUhZSUNMbDdVK29sTFRSUjJJYW5mU2RyblY4VlFzOW9LWm85?=
 =?utf-8?B?QnMrT1EyL09HVzFWSnE2TWNpcTJwY0Z5Z2NYYzRnZDR0b0tPVVdmSE5wQ1l6?=
 =?utf-8?B?ajRyditPbmhBa2V4eUxBVHRYWDFDdWdiaVJ2OGRDbFRZZEtSVW9UQVJDdnZi?=
 =?utf-8?B?bURVUCt5R0dZWEpVRjFQVlRvaStOUjBPOUZGeDhFMUtxT053ZHB0ajMwaXF4?=
 =?utf-8?B?Ylo3c2Y4Tjg1V0VjeDZtQkFVOUdVZ0x4NDRHQXFLZlhsVGpINW9Qb05zVm55?=
 =?utf-8?B?NFFqN243a3h0SW9obU9pd3lONm5LdU9LWldnSjlNSFE5TWxmYU9NUWszVkJh?=
 =?utf-8?B?bDJPUzNZTlZlTGt5MnZYZHhzOUVZSTRLK1pHSTNjRkF0dnNPS2xCOExMTTNB?=
 =?utf-8?B?cDdLcTlNdHhlL2xXU0ZQSkovVk1jQXJHSW9FNjBhYm5WcUhNbnhFSllIT2Zm?=
 =?utf-8?B?MThCNHVyODUxSFlDazJXd3NkZmM3VC81QitUYXpSQk90QUFwSS9nVXV5MDhv?=
 =?utf-8?B?OGdQZWlBeDhTbkNTWVAzUG1TTE5Rak9WVXJSN01ncjFVL0trL1Q5VGNYSDFO?=
 =?utf-8?B?V3ZSQ3RnVjVjVVJ3SGhGZ1l5VnZ5VUVvNFdzeEdDZUhFS0Z5RURDNzBOTVFv?=
 =?utf-8?B?WVAwcFF1Q3BseFIrOXdnazlzV2tLT2JxUGNCdm5vSzhQcXN1T2pQdnc5bHVq?=
 =?utf-8?B?Z3FyVWVEdkpyWWVXRDN6cm0rUmV6VWNPcUpYZWIxQit6TEdUdDdjNmhCR1Fm?=
 =?utf-8?B?UlZwMktxNVZVMnZpWVIyMHJkNkpGR1FQZTlvR25yVEEzWGcybVZZMzUrY1JS?=
 =?utf-8?B?ZDNROG1zcjdzRndGQVBicUlUSkxyT0dtUWs1L2N2YjZVbXlIdDdPTFFpcUl4?=
 =?utf-8?B?OHFBekFwNXNRQyt6eC94ZHIzdUhQTGxrRnRiV1NBajdwMUM1RGQ1SjdaWnVs?=
 =?utf-8?B?WmJwRjR0QVJ5SDVJWXg1UHBQMS9tNUpwaENXeGdsZXBXVTJ3cnY2N2d2Umh0?=
 =?utf-8?B?YTNlcjZqNXM1OUZ5TE5TVzRnUFRQRkh5Y01lTmtqanhkWENuZ0g0NUM3U0lo?=
 =?utf-8?B?azVtRGF5RFFBWnNHb1lWaTl1WnJYVHRZUExZc2dkcHF0VjdBalpObDFPS0l0?=
 =?utf-8?B?akpMSVlocFczakFZbWV0MnJBM1d6UUE2aCtrQ3RCd0xkd3NLZWdXYUtscTYv?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3c4f2b-ce99-4acc-7c18-08dc7922881b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 23:14:00.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mitZBOScvcv+PF0CAgHLBaiMc4ngZCKkprd/OFv378+8Z+dmYn1K3DHiW+58gZbiz0QqWT17ojg/Mt7eQFjUIFd/udMzzCpC9Zvxvyh3w00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> On Monday, May 20, 2024 7:55:17 PM GMT+2 Fabio M. De Francesco wrote:
> > On Saturday, May 18, 2024 1:26:21 PM GMT+2 Fabio M. De Francesco wrote:
> > [...]
> I suspect that I didn't clarify that the diff above is proposing an additional 
> little change to this patch (for v4) and that I wanted to collect comments 
> before applying and respinning.
> 
> To be clearer, that diff is meant only to show that cxl_event_media_hdr can be 
> removed from union cxl_event at no cost while still be used for the common 
> fields in the definitions of cxl_event_dram and cxl_event_gen_media.

I agree with Alison, this is what a union is for, and more generally,
runtime code should never be added to make up for deficiencies in the data
structure.
