Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90AB25F984;
	Tue, 22 Jul 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200540; cv=fail; b=l+oIQ4E5EfUmo5YmK73TTYHFn6cFKTTjTEvU/sC57tOHdyaUs2H5IAfACLMgTJMcVrdjpMq3rvGfJ9vUXQQDw61LbEHNHYp35cARnSm8QbWrwgZ8/NcPyy0QW+26fs00KP5Y5fNoI1GZsJWnJZ2LwOQghILfhQff6I7JzOxdjt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200540; c=relaxed/simple;
	bh=9prbV80ecFek7y6dg3O/LnfnN3Xj7SkMNHr0M7QWIBM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WGaCBwjewLLzSAoM2wyYemREBddlvM2lb3FDe4z2TBzWtAmWoX/Zl+4gynwNO53lFNCxfeVJ+3N3pnOaXNBVxFKNXQ1N8dtXoct2k/ZsrGqYlbIsCHUZdf48MTQumf78icVJmZQfwN0b7dsiAPyZPKxFvPfGULlCruofFqZ0RPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH3AhFtw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH3AhFtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753200539; x=1784736539;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9prbV80ecFek7y6dg3O/LnfnN3Xj7SkMNHr0M7QWIBM=;
  b=oH3AhFtwayNEupwjegOMQ3aL7z9q432PmbIuORa8gfPt92KAwnnDS6Ao
   OxQ52UdNckZ8ZDF/+TCa6WRsQHgsJrusaXqU2NroRhc68TTaiAMvIg1/h
   1nxTVLq38NgZCRwnljBfW7ICsG8F99JcAj3ic33YrutTvFGNlV+svLLDz
   oZNoRFyQZxdZaaj/Fe5Lb1na6fsgNqjABNLRvEE8zVOSnQghX7ZPJN8Lp
   UUjVnumA+L/40DJpJy5L7McA8Y8+fE9EqAhz1i7L6trqviTBKr6/H51d6
   /Z8VjPKV/SsBft+UFRS4fjcJdh7sgCeDZMW4jWdEHSXSFBVnKsrFJFSuw
   A==;
X-CSE-ConnectionGUID: uEa/cau8QkyWNeGqEeEC5A==
X-CSE-MsgGUID: dSKuGT5rQA6boONmbuuLYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59261418"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59261418"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:08:51 -0700
X-CSE-ConnectionGUID: A2lRxnYnQliBady6ZkQCIA==
X-CSE-MsgGUID: h4Duh8V3S8G6kHCxC0i6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="190156196"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:08:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 09:08:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 09:08:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 09:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpkM2Z8/2kXdrgArIVh9LgoUILpcmDG4eKZxijE5gAEv4F1nZL6GDI8hV07I+JNmS4K5a8NytsXAv7Dbzh/f5pfgvCVIAikHoIwg4MaQXZHYPE/ySvyZtlVEBMaiP+xM9fdKvkMsPo24Fypa2M7+kLSaptC6eP5QSzDrbFnoSed7XGuVW4e/VW9EaoU/sU4Zr1mNBUKfli6EkvrDxF3E9BCew95DRgGywtdPZi9RNcGe3C3eVlBOR4G+sbe1/pKfWynj5wsxaWc1wBULlze1f4gctLjUcemiL883Wu0e/7IHZN/hHhun7nsuw99tplz+Aom18gvyBgL4QvYq0O4H7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmeHgeiuJGxA6MuOkaYKfl+/iCNfPbkeAlvM8BzbS64=;
 b=jaClFkk2jzyGpiAIIZOoXjQ83SLjyBJj02omSdj1304rWsUqM3AcVGRgG4aUqAxFOhmgb9ezfOYTI+HGN5dBzmS1iEF9GfACl4+uLBbSMuydZzJIfcy4B+csGpokaKWYLMa3YLJoOtcnp9eCdLihL5sIOxdjoPII4HRuFxi3RmT/dqmZaiE9QyaUU9XmA7YT195Pcbg3slScQ2YkPx3zXT82wNvyO1cH69A3dXuWEnORw6hyFwLlypJ5er74zPyQdUedUlNdhFxZPtZd4ueewksF5hdBiu2GuPcIJqr5efGD+/XxPYurFCajw+Lxn1p5/aLGZxwZEFNHmpZ2TI4jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 16:08:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:08:47 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 09:08:44 -0700
To: Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Message-ID: <687fb78c8d44b_134cc7100f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <CAC5umyi5ZwAR+nEPjn_5m2q7kjE0uyo=0pzv-s7uod560iGJEg@mail.gmail.com>
References: <20250719112604.25500-1-akinobu.mita@gmail.com>
 <20250719163144.7524cfec1fe2041742608f80@linux-foundation.org>
 <CAC5umyi5ZwAR+nEPjn_5m2q7kjE0uyo=0pzv-s7uod560iGJEg@mail.gmail.com>
Subject: Re: [PATCH] resource: fix false warning in __request_region()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 08eb38ac-e823-4d29-a004-08ddc93a0a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTdOaHp4bG93ZEV4OGVYYTFhMzZyRHd4R3AyK0hCWiswWnBhRnRKQitGUXRr?=
 =?utf-8?B?TjN6ZUhMV0ttWTU3aG56OFVMRXJTOEZnQXFUVHFSTHlVOEJpUk0zOVJMdzk2?=
 =?utf-8?B?U2UrTGtEVXFPQ3R3djRFanM5KzJoVXREbE40MlZUOXQrYWl4VSsvRHlubGtk?=
 =?utf-8?B?bDdhMmYzeG1waGRjbUNDNFgxaFdZeS9lZWNoZHhwRE5tR3hHWFpFZldYcU5z?=
 =?utf-8?B?L0wxc2NBQXh1T2pXVTR5Z2xybUtGSGxCak9jVE9GSHdLQlVmMkdRemF4ODE4?=
 =?utf-8?B?Vlo3ek9wOTdaM0ZLcUNReVlRNUFzdm1kWWRuOVlXZGo1c1NRSDA5RXUwa0xF?=
 =?utf-8?B?SW14WkdTZjJub1JEbm03aGxnU21wc3BrbHBmNVVROXNhQVJVZ0hGSmU4SHNv?=
 =?utf-8?B?SWJGQ25aSllOZTZLUk1IYXh5QUY4YU9nN3FkOXRxSmVnSUYyYVlZQy9RYnUv?=
 =?utf-8?B?UnZndFZ1Wmg1cUR0M3BwSUw5VXVJaCtkUmRhb3hBUkNHUVFqdytPOWlyOGlH?=
 =?utf-8?B?Nk5RWUkwMDJTUi94TnBqWUl3VDRrMVJiRHlNSUxGd2Y5cHQxUkJKOVE0V1Yw?=
 =?utf-8?B?RFVlMUFVU1U0UkpraUFZVWtvUCt2MzVEVFQ5TFJUdEtHa3R4MHdPc1A0dnRi?=
 =?utf-8?B?NytyaDdwbVVUclYweWdFdllTbGxqb2w1OE5vaXBUM3E1QTZxdXYvV3NyaFpj?=
 =?utf-8?B?RDlWVHNXN2M0YzlMR3JETFlpbHNQSG9vdzJDNUd1c0VEUi9wdjB5UjJKdTZq?=
 =?utf-8?B?NDlCNlhOMU9nWTdrR3BLcFMzQzJITmRIVG5WR0lpOGk0dlIwM2FMOEJINlVW?=
 =?utf-8?B?MFlRMEdqcVJpR3AyNEFKMHRxUE95SlV2NlpPSUprbWRrVWJCYjl6ekp4cWo0?=
 =?utf-8?B?WWlqL0h0Uk5VZnNabmpnMXFQNjEwOVpobEMzd0RQL2RIU2YzM0tLbXM4RVo4?=
 =?utf-8?B?TWdmMzFobSs2K2loYVNuOWZJZUdrOUVkcnkyNFk4VFJrb2Z5QmRvOFpkNGVq?=
 =?utf-8?B?Z3NDVzNybE96QzgxQXlJcEVycyt4UjJ3cHJIaUZ6bVlGazA4cE1sanJDNHpX?=
 =?utf-8?B?TGNJdUNUcmJCd1ljVGp0QVQxUVc3bnBBSnptTWNiSTE2cDY0VnM0RmM4bkNr?=
 =?utf-8?B?UzZSeVU4Sjk0WjZXK0FrS3B2T0NiY2xxS2pqWFVFeUI0NU5tNFdvV0dHVVNt?=
 =?utf-8?B?TUtWVWRSam5GQU96eXB5WHlYMkQzdUZ2eWgyYWF2OE0rRWNhcmNnSnhLc0V0?=
 =?utf-8?B?dDBNUWd4cXBKZjE3aVZURit3bGM5N01kdlRka1A5OWlkM2pJNnp6SGJqSlJx?=
 =?utf-8?B?emFKczFRK3VYekF2Ti9KMisyeEJ2b250S09tczQ4aXZSSTFlWllsTzdIOU4r?=
 =?utf-8?B?dXpranh3SFpzWUR3UWtoOTRVNENxaGVERXI3QTlRVXBhbTZuL1BDUjEzWFBN?=
 =?utf-8?B?OXAydWdPY2svUlJQWjBLLzRRNXZBc2VBQU5TWFB5VVVEaHVPSXREQU9pQ0dk?=
 =?utf-8?B?NGppczM5U3p2dHlGQkZEb0s4WlRXL2R1M1d3b3ZiRXJDd00rZGV2WEZVV0VB?=
 =?utf-8?B?SzM2MFIvQ3ZnTGhRNGRUczlKVjYvSmxCSDIySTlYb0VtLzVnQjVrek84MlpY?=
 =?utf-8?B?RWRUQ0x2TmIyMlFqdWptaWNsVnRMMzg0UlFVWU1oRVRrcmFXZ1BCdFJPOG9p?=
 =?utf-8?B?UDBhSlFwa21GMjl0VlNDTkJCWURiTVIyVlJnRU14YjlNc2NPNU1rVFhjcEEr?=
 =?utf-8?B?bXhXWTUrNldVcGxyMjFlMjdkcE4veDU0d1ZqVSt6NXNNbTdmK0RhcVhaQjVt?=
 =?utf-8?B?VGZvTGRtd1JJRUs3SDVjYVRBT1BZZDdEZHord2d4RmRMTjJjbVlsOWRZMlZ4?=
 =?utf-8?B?RHNlV0hnUmVRV3J0Zk5VTkUrdUVJUHVQN0RuQUxtalFPaXh2Y3Y2NXlVKzVw?=
 =?utf-8?Q?4VnY4S5ZPXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0xPT01ZSEFkUGlkcyttMzFlWlR5bXJ0ZnFGRUQ1bzlLVDdnSGxCN3dNT3g1?=
 =?utf-8?B?UmtFT2dNeUpHYUFZeG1IWW9wZGdHcmxMOHRQL3R5V3kvWTJvdXdhUmh3MFEy?=
 =?utf-8?B?UVhqWVY1Sy9RMysvenlYUTkyNlp3R2oySFgxM3lubzlIM1FUamJ3UUpGbVZp?=
 =?utf-8?B?RHZqaHJPNGVvdXVVc25sZU82cDNkOGFya3doeTFleXFMUkhxcXgrM1RTNlFF?=
 =?utf-8?B?V0xxbFJ1TnczbnMzSEFBUG5Ma2xhbGZxcjI4cjhEZTN5dGhUS2xsTWdRRWZa?=
 =?utf-8?B?dFc2cXBodEtPVWt0bTJFa1htZEgxazZRMzVYaTAvZUlIQms2Z0J4a3JpZU1Z?=
 =?utf-8?B?Ymd2STNQVVk5akc5VVMrTzBIcXRSZzlhR1JxZEJUVlEvWFllVlhpbnpVak5o?=
 =?utf-8?B?ZGlrTHBxUm5CZnpEd2lRUVYrcGd0RVJ6VHF6YWxSaEtqZFpjanpSbjR1aCth?=
 =?utf-8?B?eThwL3RxY1grMHY3RmZPVzI3Zk1HNlVlV0NPVkx2UlF6cHpwandHMm9sR3Ju?=
 =?utf-8?B?L3ZTMzhHMUZYc1JwUlFzQWNYYkdvaTZ2eUJFajFaN0pHdG9hcVVBczIxZjY5?=
 =?utf-8?B?eGNrbnRXc0NwT25hU1ZCWGRJUmdjWHhlUCtHVFkrMzhyMGlkVm5mL3dkbTl0?=
 =?utf-8?B?UkhEYkRKdGd1NHkwVjlibW9icXVFNWg0bUIzYTJBM2hOdDZUQWEvM0dhcFpL?=
 =?utf-8?B?aVp2SlYvMVpIN01Pd3AwTzg5VlB4TzNQem96SEdubXFCbktTRzlnQ0hUcHl3?=
 =?utf-8?B?eUYzaGgrREh2djMvMmpGRUZrK3VvZkIxS2NBNWltQzFzVUdjR2JHWHN5dVJK?=
 =?utf-8?B?OVdtYjZxSHBFai9NOUM1cDhlQ0dnUG5LenpZTC82WGgxN1ZDWWRCcFpNd2xN?=
 =?utf-8?B?OUF2WGNtVXNPdDMycDBvVXd3RmxSLy9PRC9NTXJScGxIZnphZ0E3Z1hXMkxo?=
 =?utf-8?B?bExIQmpzRWJ6RnBiVThJZWd2QVBFYlFFQklGTHZ4N0xYUVlFb016RzVCK1NF?=
 =?utf-8?B?ek1hM1cxNDV3WWZkcTVib01FZWtJeCsrK0JZVnkzeUsxR3JtaWRPR1g4RnVQ?=
 =?utf-8?B?bGxjQXJXVHJnd1VhN2JBaGJHWStuMVpNWW85VTUwRGJuVTFKcGJteDVRR29U?=
 =?utf-8?B?NmkrLzFTUzRzd0lUSVgyTkVRdzhSMDBocS9lUG5HbzlHdjZOUFp0b3lScVBZ?=
 =?utf-8?B?anV0WVNmcUdZcjN2TTFzaWl3d0tCYVk2aUtCNlJ0VzV1SndrS29pcXdlUG55?=
 =?utf-8?B?OVdtSndTSldwRjR6QXdES0N0RnZ5SjZMeWRLcXNrQURNUysrVDBaUHhlaGVT?=
 =?utf-8?B?ei9jcXhFK0ppeThlMkhsRFFPemgvdkE2T0xXV0RxUVh4TkFjWnRjVmh5ZGtG?=
 =?utf-8?B?K2lEQ1ZmdWhvYkRlVlpPbEJ4NThZWXhLZXEyQnhxV3NTZGN0S1l4MEthWVhC?=
 =?utf-8?B?S2h6NU1TblJqS0pJYlN4RllMWFFsZ2xHam81RmM0VzZYYlF4UzQyaTZ4QlFt?=
 =?utf-8?B?bWRBSDdMMDlTR3RLOXZobjY3RncyTnNzOEU2d09YM05jQmhBV1Z4SGRvejhE?=
 =?utf-8?B?ZmZQUi9kNkNOdGxLckxMcGRScGtCb2JlcE40ZWsyOVpVVlVlWXB0STVseCs1?=
 =?utf-8?B?UmNMdU1uYytadktva0lyQ2xCTFUwMTNzQUhMWGllamlFeVVJcndnZGl3Y3g5?=
 =?utf-8?B?SE9xQWZoOXIzb1hJV3FDYlFQMm1tVW1VcUNNRHo3bFAzNlJIK0pRanJOQkVM?=
 =?utf-8?B?L1V2ZU5ROUlEcTEzOWQ2anN6L0srSmNIaGFCUVFmU3FQaFpUNEJtQ1hEcHpZ?=
 =?utf-8?B?emwvdDNVTStHUFNpYktpb3YvWStVUG1BTHN6cERlYTZFanpMejVlUjNhcUtL?=
 =?utf-8?B?NnNZa2R1UzBWTkM1bzNZVkpjQzJsbVc2ZWVIN1pwVFF5ZmFOK3pNc0ZIZWd1?=
 =?utf-8?B?NWZYaHpyRUczZ29RU29PaVJmWDg0eVU1L0ZVWDFmZlUwaHRBdEgxQlduTFV5?=
 =?utf-8?B?bTk0a05MNmR3ekVCWnRiRGVFeFlVYXZoZHpPRHlvN3lXWHU5Z3MvQUh4Si9M?=
 =?utf-8?B?WFF2bFNxZG9CZkJJeDBEd21yMzZ0cGhYSFVuMDBZaXBtR3JsNlJQd05rZExE?=
 =?utf-8?B?ZVlWUU1CN2d5ZHVQSk1yV3FMR2JYbmRWSGh4bjAyREo3ZmxBNUxmVUFDV3Vs?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eb38ac-e823-4d29-a004-08ddc93a0a04
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:08:47.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUHAWTGIUlsIYL77gpK1wbF3cJYomhtKeY9Ugqj1WXJIAWDH7Ogx+vMpQftH5n0ssaBw6aKJDgjMvkiZv5BeaUfH6kmEKitSMxI1TEaTNB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com

Akinobu Mita wrote:
> 2025=E5=B9=B47=E6=9C=8820=E6=97=A5(=E6=97=A5) 8:31 Andrew Morton <akpm@li=
nux-foundation.org>:
> >
> > On Sat, 19 Jul 2025 20:26:04 +0900 Akinobu Mita <akinobu.mita@gmail.com=
> wrote:
> >
> > > A warning is raised when __request_region() detects a conflict with a
> > > resource whose resource.desc is IORES_DESC_DEVICE_PRIVATE_MEMORY.
> > >
> > > But this warning is only valid for iomem_resources.
> > > The hmem device resource uses resource.desc as the numa node id, whic=
h can
> > > cause spurious warnings.
> > >
> > > This change fixes this by restricting the warning to only iomem_resou=
rce.
> > > This also adds a missing new line to the warning message.
> >
> > What are the circumstance which cause this warning?  Are real world
> > users hitting this?  If so, should we backport this fix into earlier
> > kernels?
>=20
> This warning actually appeared on a machine with multiple cxl memory expa=
nders.
> One of the NUMA node id is 6, which is the same as the value of
> IORES_DESC_DEVICE_PRIVATE_MEMORY.
>=20
> In this environment it was just a spurious warning, but when I saw the wa=
rning
> I suspected a real problem so it's better to fix it.
>=20
> Fixes: b926b7f3baec ("mm/resource: Move HMM pr_debug() deeper into
> resource code")

This should be:

Fixes: 7dab174e2e27 ("dax/hmem: Move hmem device registration to dax_hmem.k=
o")

...as that is the change that violates the assumptions of
__request_region().

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>=
