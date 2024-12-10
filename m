Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599588633A;
	Tue, 10 Dec 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861312; cv=fail; b=tBLmZSpthWX/lV32ITowuzGxy4njEGLCd9RSt26rvjqcGWa0OyIcBfgtfYNs/z/65spCvqa9dIK/m6vMDvVqyBx4OIHQ5Gdbl6Z/g8NorC/gVuDGJVsHsNJgC1PJf7GufRz/kwqGM2W3GeWjbAc03M3DUuGL1L8kf7HDxr/svEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861312; c=relaxed/simple;
	bh=M58AKe+pVZDtc++gLrGu+pkFe3cpEYkq/KBohl1Knmw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kUwjLo2O0a80RaQLCKK0Odv/MDEHcMr75p6DwiEicA//ezl61DWCFcAHjeeUiD3CrBMfpW2tgxM7Iep1Mj6MytFX8xdOiJwmG7ZULeIToPLL4s0w2LzYXfyZI5wlR2w7HL+PlNQ4+ZvEQGsqjX2S9JXY0cZzSvlpmubO3BGBjGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7R7SsmE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7R7SsmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733861310; x=1765397310;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M58AKe+pVZDtc++gLrGu+pkFe3cpEYkq/KBohl1Knmw=;
  b=a7R7SsmEjJfUAXVpsTK/zPwQCxcUrnnYcoWS1Gwu5w9mg4mYixk/Zp0H
   VNAOdJFc86myf92fYtng1F+10QjyyVVh1pImXnaEIcu9mvbEnDXHXWKJU
   C3KR5Aysdi5feNTTk9dFTwqRwGjgrxnpyyoyIlNN9skQ5mwiFCD+VqY5+
   YuUaaChsOH0HorPO0Rdf77bQKF4gcKbLrq4fRh86SN4GH+WRCoP54eUBc
   tIjxK+vD6tJdcCCwYBGsrd+csM+tWjyAupPc9sOW0c3vYprkdlr4bTQHT
   vea5fWyp4Y1j23B4XkEqW9kBSnMEKnLDjYW5x8/EJP8dScT+oySPSSn3T
   g==;
X-CSE-ConnectionGUID: beEUKzwoQiCqcHLeXDOeyA==
X-CSE-MsgGUID: ym71a00HShSlKGDZvUzwaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45624506"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="45624506"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:08:28 -0800
X-CSE-ConnectionGUID: vFoMLDXqSI6G9ESX+teoBQ==
X-CSE-MsgGUID: Y1MEZA7MQZuoy/XjZBOcVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126330342"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 12:08:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 12:08:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 12:08:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 12:08:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvMBREGd98kuzYVKb9NXH56p0LzaTz+JVaY9IiqDUK5/8ECsV1NCjq1YGHAIs+CuAVtvjvA8wWcvau0LWW/u6sSsicSCWb8cx4yXTg2mWQdvOgWJK+5Hb5I+in6oZAZ4eE2vfQIBQVHBWQnhkDjJaALHI8bbvoe+u3qEZK2j0W7DWNkCJ+TUdil7vCS5ey+uYf5i5a1uOeaoGqkCc4ON56fg2rX8OG+7E6uZvH3xiebhnZ75YSGq6d5nqUjT9gc0jSIX/yK+ou9o7otK9I35u6C7Ml0aKPikybKgFq00qe+ZWczpO9vmCG7nQBCW70KCQsaPQjb8l4c/Mk13wtMKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGEWISGpqaP/oWAp3qCLCvabwLocXLEb1UmEqJz058M=;
 b=ivHmylSPHhLaJYXpSX5zl5iNSdA+EELNzzc2F/rMo4mcUdZjAPPKClvZh4uIDopMoAK4rMEKyAxZoT8DQEWAvdi/sFdiczT6dKVJGlyzBL1ABq3RmSy0CQl2oxjlZcNHQJSNPFXtihxzdl7tvuHU6Lh1LSPTWCaSRDyGk2XEoa0EyOFG04mFqz2YQDlbGAJQcIfyEicdNIVKKGOAfXqLSAc+ZqcS1rLKl1X0IghzK6t44hHt25Wo+ob9inhjXz6a4s2y6aWvdFUFBwXuBTxMnD/Xhp80BrfCN+z0JEq0mENSQuh6MH0lC2npWtO1L2ysXoEfJp1bUB7RMfNob4trEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 20:08:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 20:08:09 +0000
Date: Tue, 10 Dec 2024 12:08:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
	"Moore, Robert" <robert.moore@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC: "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"gourry@gourry.net" <gourry@gourry.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alucerop@amd.com" <alucerop@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <67589fa6c84fe_10a083294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241104084110.583710-1-ying.huang@intel.com>
 <ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
 <878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zy0kt2i9C6eirhPN@aschofie-mobl2.lan>
 <672d329119d63_10bb7294cc@dwillia2-xfh.jf.intel.com.notmuch>
 <87a5e762gc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1595d6b740602682f12a4e502e459b0d82e48711.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595d6b740602682f12a4e502e459b0d82e48711.camel@intel.com>
X-ClientProxiedBy: MW4PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:303:b5::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3695c91b-0682-43aa-e8e9-08dd19565e34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?slYZCS4A0Ai3jugW5VefX5YwSS8DtGpRJcXpdKFgIy28Fr1pKXmeANZ8+f?=
 =?iso-8859-1?Q?qNL9ZHxWjY+WD9AQZzgdyaho1/rcAmKHk8YQkgvrfWvpFVgEdo3jdV1x1W?=
 =?iso-8859-1?Q?l8qAiY7xD5/e3ynS6sT7tSWvgOggJWP3mhdJOJBXXndStl33i+Fux4O0Tk?=
 =?iso-8859-1?Q?Jcc3Zae8uyM29mrOLM2k1qARtvZO40etGm7WZlXYAsfYFN1ThixQVAlO/Y?=
 =?iso-8859-1?Q?FhR+vQb2JBiHe+i1VyywVH1TYdG8pmKgHxgWRytcsINCZm3zNP+T4qxS88?=
 =?iso-8859-1?Q?1HQL7lwDb/8NsiYDong35QCYMS37bMuI5cTFNBs1+KQLxkAA1GnlVyVtbB?=
 =?iso-8859-1?Q?gPyfW2PuTIWq7eGukfukbtdSdZLPnuWcNbFrFGVE9nPsDdLKZeJUu2SjYX?=
 =?iso-8859-1?Q?4eucalCG64QOnSePD+6K7WyoaUIGvnWTvX/u2PvAavMnU+jb9Ftn0ZtdOW?=
 =?iso-8859-1?Q?WR806KoX1w/dNfSxzuvsAho1aygyzJvdLdjy2JFAvMGJGeMTXEURuO7Fwe?=
 =?iso-8859-1?Q?d3ISPN68C1JJa62/yhIhMdUEMXR4ZMKu499KR8LMSHic5cS+AzlUlKI8xd?=
 =?iso-8859-1?Q?zyy6VOW19bEUPo5V1oWrRh+yZYY6PaZtHezDkLJFEWIYwKFr+PMFFgcPdW?=
 =?iso-8859-1?Q?3842RHdgM7YntoG9MxjhT9Yo/KHlvS4URtX2LNhd4dYyfziEbsXfYiNyDO?=
 =?iso-8859-1?Q?sLHVb3V+6sIOAaJwB4oiNjbtOvsmT0sVAttqwYbzhSMoc+Cbk7+P/DhJmk?=
 =?iso-8859-1?Q?4bYrQSoGL0cS2szRVtERdLdkCjFjH+HvUMVDW9Wakg/R8xKy4y52nHtP3b?=
 =?iso-8859-1?Q?x0Qau/fY7hS6JjKjZrzcD8KJXsLE5N6V2ezBytjQHafam7fYnd/bNShgKz?=
 =?iso-8859-1?Q?Ej8bPzgRXyN9+/MquRlpdnCecUGLsobYfGu/dS3KixVJQyNLUX5ST6tK+V?=
 =?iso-8859-1?Q?2IP+5azNb8v4kRPeBKrt2nELplh8vtV7WzYi2BQsHtgC3RFz1FzQEpoO9y?=
 =?iso-8859-1?Q?R9Ng9t3Vp+dzwx/oL27fxunj8RmXlIpdKmql0dv7Tc2QaCGH3cc7S6JDuS?=
 =?iso-8859-1?Q?o7KdG6iuJcpupvZjWU8YUovXFvaBiSFIA4+4szQq0snm2Dijzg0hKwXWMY?=
 =?iso-8859-1?Q?zA967zluMcljJSqvN6Pudo/bAglZ0PmRY9pXRne5rPTipSbPieVQyyN2wd?=
 =?iso-8859-1?Q?hcXDDZS67Qu59VkbiyZ2j2GMDy8NxzhztRfRODSf4RX7jUoIhVhX5+ujPf?=
 =?iso-8859-1?Q?LiWLb+aUFyjP+SUve6LhVQcwbNMPVjUrP7xWEE6BvENA2WR3ebO51KOZlO?=
 =?iso-8859-1?Q?4Lgy+wWi2cFiqDNGiJbDYvBZi7vv4/dTTcTNnjpBvDWcAdWewGZ2ACVjar?=
 =?iso-8859-1?Q?mbR0JOyssqCDM+c/B5pKiu5HH/XxRAhOnK35PKbdNEzUMPVXLfRPqkb1Lq?=
 =?iso-8859-1?Q?nJjCOG+k1Svste/KA7HGtbwRUuJSoB+y5csXkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6+/GuYxoetigBG1JJhxbu7XNS507IV4cWs1hYhOE0HcYj1zZUaHUNvOcnI?=
 =?iso-8859-1?Q?ALpVwPUudjycxf2NNHLXU+l79Zl1sEAS6Qtf3VAEf4WdLhWyDHUCuxnSoe?=
 =?iso-8859-1?Q?U9tNULG7xNbVaUjVoNU/wDHpJnLYlUpxW0bc5w5p9YnqPDm9vDkbA9T0YZ?=
 =?iso-8859-1?Q?u/iVDYqe7a20lgq44CXm1DjN2jkoB9WJdYdGHpUUTXwCyfZ8bNrTIZ5T5F?=
 =?iso-8859-1?Q?CnPOXBo8cB+vh03KKthuBNdFPwovYdFH4gGN2lAFUAziUddKFXJthjKMfl?=
 =?iso-8859-1?Q?Fx2+dXJwM0FEp8ho3yIw0Q722S+CU2l12ledDqfe4j46k21EYO2XlMJGPc?=
 =?iso-8859-1?Q?mDpJoO+AnpMvP3WaYPEdOX5N6EKlTLvvm8zL3teY2ATHANCu8kke5zsOKM?=
 =?iso-8859-1?Q?g1RGfIm5KpZVJGgDwAmqzrln8Jx8wXhDC/AOOVjqGyaR4aehD+kO+nhUwZ?=
 =?iso-8859-1?Q?FKAMSrEf6cODwXsFW6X1GEMUhlY1V9+1d/guBFWk1DcX5QC3AaJC9HfOXQ?=
 =?iso-8859-1?Q?M53hSU8rtF2ScUGBsjHqU87lI+yCezcv6gtKPIyMkaA4Er8h7oEbQ4lBFw?=
 =?iso-8859-1?Q?d5PvJLpjTEIclt14cRR7hSdaOZynCTb+w7gzn2+JM6K+/e20R0gyiqtemm?=
 =?iso-8859-1?Q?FOmgXK2scW6Qy23Q0SoaLN9PBusI6DACFCsRToAndTJCLdiycX9NZR1iAQ?=
 =?iso-8859-1?Q?rrD+51KRHotqVTrVbMd8s2GMspzGo31N8rw1ymCqiTe+Pu0vRc9Rl+aYxK?=
 =?iso-8859-1?Q?1a5s1tAHKQ6/UIH11dgbOiFy6k+Z6l+Q2vmJ8gwJduSk4jzeI4hbiGwUmC?=
 =?iso-8859-1?Q?1SCt3eNjgW0kK1lmuvYPTamXGfeLqR0U+7wkULCG40ohwtEwaLdr9G0eWe?=
 =?iso-8859-1?Q?VdlY5AegRfyyQMecpny9Xw6FgSRUA0Ez71+Z6GeldrLuvosgOy62N9qRNP?=
 =?iso-8859-1?Q?q+0pwdCaI14r1ZUZCg1uffK5jWZsh5VSZjox6kVWCUepNSc+q5a7qlUFNn?=
 =?iso-8859-1?Q?jB9oIOgR7dkVrfNnAV25wvTby8UHU29NVNXtn/f9lhXxgoO2xKuNJhHOpo?=
 =?iso-8859-1?Q?qJZXDnJ4YipOQ7i5BaxgggwlGAxB26mPY6tZtOwWAjpHZh2+oIErg3/sIi?=
 =?iso-8859-1?Q?Z28Z1iMhXIZPxqncNO36hyd0bkURcBVdBaxUYRsdeuCajkjrhmBkZddyVh?=
 =?iso-8859-1?Q?0HL0MkkkTWV5zyb45bLAuG7m1kMaiS46yolPSIidPDUXMOmtNgTau2MtFk?=
 =?iso-8859-1?Q?XCkAv0m2/XZV5GK10AMz9MxFvlwJDgxyiOncAw7mbDEbHJgD5G4IRSuYA+?=
 =?iso-8859-1?Q?l0Ty555pBGENGoM51AY6qCsDZlOxd+nGsFa8MmVPWQiu2LFRfxGoSAJ9DN?=
 =?iso-8859-1?Q?doqkEeLCs6FUf+9m7sK1luPfM7zTHCnH8x9oz8ipoHOpfYdFGNgE9T5SVX?=
 =?iso-8859-1?Q?1bZJG/7+TYYO+/9iMZJ7o4Idlq/DvYX50gn86R+IOwJ5HRQPK8kuD7we7x?=
 =?iso-8859-1?Q?e2uM4G1NOOUBEV4kwkfxumGYg65vUGC94KQKcTndRh0H4ud88iwAHuMu13?=
 =?iso-8859-1?Q?Y0NonSrlt+iICg+7VkSp7ULt+2c1I8bCcIyj1dS3sLGsrWrpLV9cSCh2J/?=
 =?iso-8859-1?Q?HUC3NkGHQuiWe3+Flvm7404mfYnjN4Pu4fXwmoYOYtvWP8hog7nd87iw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3695c91b-0682-43aa-e8e9-08dd19565e34
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:08:09.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n89l8mFdbPYIc3IFXDBXsIV18tHZhLm6k99s19BNHr8MV7xmedyQqwubi++pqd34pOXiy95l+MIrhIcEFUAjTHA/7Q+tin5k1ai2uUXr8z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
X-OriginatorOrg: intel.com

Zhang, Rui wrote:
> CC Rafael,
> 
> On Sun, 2024-11-10 at 14:13 +0800, Huang, Ying wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
> > 
> > > Alison Schofield wrote:
> > > [..]
> > > > > I think so too.  However, I prefer to keep this patch just
> > > > > mechanic
> > > > > renaming and do these changes in another patch.  Do you agree?
> > > > > 
> > > > 
> > > > I don't know. I was just questioning where and how far the naming
> > > > scheme
> > > > needs to change.
> > > > 
> > > > Maybe Jonathan, as the Suggested-by, can chime in and move this
> > > > ahead.
> > > 
> > > I feel like we are going to be living with the ghosts of the
> > > original
> > > "Type2 / Type3" naming problem for the rest of the subsystem's
> > > lifespan
> > > especially since they were encoded in the ABI and ABI is forever.
> > > 
> > > I am not opposed to this localized rename in drivers/cxl/acpi.c on
> > > principal, but in terms of incremental value relative to the
> > > thrash, it's
> > > questionable.
> > > 
> > > For example changes to include/acpi/actbl1.h need to be chased
> > > through
> > > ACPICA, at which point is this rename really worth it?
> > 
> > I think that it's not too hard to change ACPI tables definition. 
> > Added
> > Bob and Rui for ACPICA related change.
> 
> For the change below,
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 199afc2cd122..e195909928df 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
>  
>  /* Values for Restrictions field above */
>  
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
> -#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
> -#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM        (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM   (1<<1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
> +#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
> +#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
> 
> This change is made based on the spec update, right?
> 
> Do we have any user(other than Linux) for the old version of spec?
> If yes, we probably need to keep the old ones. And IMO, if spec changes
> and the bit definition changes, we should introduce new Macros for the
> new definitions, together with spec revision info, say something like

At least for me the thrash does not have a signficant upside. The more
important terminology concepts are within the CXL core.

So I would just merge this rename below and call it a day, i.e. leave
the cxl_acpi rename alone.

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0fc96f8bf15c..b9083ce1cf74 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,13 +315,13 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
  * Additionally indicate whether decoder settings were autodetected,
  * user customized.
  */
-#define CXL_DECODER_F_RAM   BIT(0)
-#define CXL_DECODER_F_PMEM  BIT(1)
-#define CXL_DECODER_F_TYPE2 BIT(2)
-#define CXL_DECODER_F_TYPE3 BIT(3)
-#define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+#define CXL_DECODER_F_RAM         BIT(0)
+#define CXL_DECODER_F_PMEM        BIT(1)
+#define CXL_DECODER_F_DEVMEM      BIT(2)
+#define CXL_DECODER_F_HOSTONLYMEM BIT(3)
+#define CXL_DECODER_F_LOCK        BIT(4)
+#define CXL_DECODER_F_ENABLE      BIT(5)
+#define CXL_DECODER_F_MASK        GENMASK(5, 0)

 enum cxl_decoder_type {
        CXL_DECODER_DEVMEM = 2,
