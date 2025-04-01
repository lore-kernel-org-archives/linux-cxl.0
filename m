Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF45F4ED;
	Tue,  1 Apr 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550500; cv=fail; b=roT7XsyeeWlY/4Yq33YszPsXsGdejnTfIhePKk43Pa6A/jeGi8w8NBE6WeIyrpZLxkuDKNFQqDsPgcqnJUmHzX9q9O5GBhVrPbpn8Dtmr8Kv2M71YOHIBlAsjQmDfkW9eflqbXu6d2B5JiCx7clCQgmkJda4OcEPDFG0TVUSC5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550500; c=relaxed/simple;
	bh=TuSLii2y8g9huLt1EWIlurrkJt1uHSGwiUMt7i8VCo8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQF5ezcFHa+9nNvNjPkLrBxFc+A2QPl9Xdhic0wVfWgg3E629TQuMILNbfHv0OpUxl+/K/HSnBKOgKChBz8xP/D4e2zMErzb7QMuH3ER0/T87HvNTLQ+uMUQD1AagMZA59+1sQdPWKNHR/CwzoTpzzmhmdrsWvC9uWA1jVvOjxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqkkUsXQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqkkUsXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550498; x=1775086498;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TuSLii2y8g9huLt1EWIlurrkJt1uHSGwiUMt7i8VCo8=;
  b=HqkkUsXQNdNzvBLaflPry2a/MVR9lHjrnbz4DJK0k2R0OWkvQP3OEH/n
   7bSnwRwb0d+V9nMgcX9mVdbFnzqG1TVvu+ULyJGf2TqTNbvjyuRAW1U2o
   CeH6RSwWVJhh10Tyct8Tst6dKcxVwEF6u2/Jo2IgbD1k9eYzAoT9/MHOO
   2Sa+dchFE2pSTXB3PKKz4xypqEqspQaqT3+PUmpQtQnoRUbKhkQMvbzCj
   3FrMZMH7JHPWxmES0wL/R2hbp+n67H/LGxQuxvjLWyxuO7se2RSpRP3cD
   eh33cQEEkt22DLRVGh8mNn5XZfzQ3pJE/382JfsHbnQhEssOhL614jxYg
   A==;
X-CSE-ConnectionGUID: m6GrG1+1Q5eU2G+HWzPRFA==
X-CSE-MsgGUID: lgFbfESeTcKIY6hMZC0N1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44804653"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="44804653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:34:57 -0700
X-CSE-ConnectionGUID: pzL24+d8TtSTWlImRdUg1Q==
X-CSE-MsgGUID: prkUVsSuTPqCrbwVOW+8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127044084"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:34:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 16:34:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 16:34:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 16:34:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdGFMDVcEtJIhPmN66IPQBgbHVLjogsMMwP38c2nQVT4/9t9NFqRJki2M7S8makssa6YEbP2f8NEY1C6f+46A/SLAbBaKG3jrrUhiU7hhvaEK9FW4APNYJlqmUX9TztH/UpOuz2uhlP/x6tIq4s8v9fW17m8zdLREENQx0t8CZt0NbKs67D/zfKHueL/L0dJ/0aeCTxMzP5F7oi8EpeN/2bJVZs0h6zNTaYrzMTMsLX8QSCpcwo9JXeKsBK5ivaU/2Gx+eTON+a7M3EjrcK2/sWK0AzObDLXBVWEsxzhHhlINSwKxq3CzVFajA53nxAd8JQx4Yf1hHGa3qtyuZ16hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfN6XpOdOFhTPHoxe74nob7kFZhBHxEPLlXDVxOHyFc=;
 b=WV3RFGxrtwdYuSCt6qFTpZVKRcGWkLVhGVjmM/RjPp1Zemkiea5NzVzz/ij2Ye1Ixf1D8it8NSJcobA1BtAlvjMzzf6beBoXYj49U5IBjF9ItLL37M2Pn/76V/0SbU9c4UkHxZN2VWS6psXb3iRtDSBR+QhPLvuc9fCXYLii0hClA3U+VxzEQQOMRodBNLS3yQflOq97q6nj8tzK1ZCK1kGPGsuOgq8mA7DN5edLQcoA0UjwR3HQR3d10HgYBuCXVSf3/BrlNr/jwPzEC+RpuutmFjgGk6LA+eE/OhLwU3KMJrDInhO/YnhNx9N9ChwNrUKFnfmdM+Jqm07/YDfZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 23:34:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 23:34:48 +0000
Date: Tue, 1 Apr 2025 16:34:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <67ec7814ea055_73d8294e0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
 <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
 <67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch>
 <Z-xdYvxD6yz3fMiE@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-xdYvxD6yz3fMiE@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: e6070de9-210e-46c5-e302-08dd7175caef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2lrhQSgjclfjMWHBRxYP9UBX9fRonnOjbHdZ4cgkZPnvuYBV1azQ9I9IZlL?=
 =?us-ascii?Q?pFEXqJqOzTELkTMY5GAGKlTm5UiFQDtyMuuEpHiR69meOkm+NYKPrnVud8f7?=
 =?us-ascii?Q?j6FeD/NIVl9itLbmCTd8w+pU9gzdCsM1ODNxMzZuBeQDuSUbR791D1zVWdyx?=
 =?us-ascii?Q?Ry+9qCQGLaya4zBiPNYhHHHZZZ212b3nEQW89y9L5yns4wnUCsU2jjRmaWoy?=
 =?us-ascii?Q?O1cCYcmXEdKL67wUpxk53QnMOM5eoI/Bwz94xXafS8oxI6AmZXqd6Q6lFk2g?=
 =?us-ascii?Q?saIyl4D0CGC28XaEbRwaTdWYZzjkfwk0/EM1RlHqjY5xD5mCLlxCTG5f2KoC?=
 =?us-ascii?Q?bTqMZzSiEzlpCZPvsXpKVQIWcxUN8KydIy7xVKkZAEG+gB2CIiJlkMKZUntz?=
 =?us-ascii?Q?uCdbnrd9eo5hEOodfF/ijgHrTrV2Z4ZKEoMwnjFN34WQtcPo1r5koCmWQAd1?=
 =?us-ascii?Q?NcvL2E+6kWg0BBZw3I7gkQEaeEJeoAqJHTXatLs0v/thI3/KFeaIlRDSnfm2?=
 =?us-ascii?Q?Ih69ib5Qpi+3o6jUFz7wIYIPzXdNXoxps87iE9Oj1ThFInfjj924r6UbVVBN?=
 =?us-ascii?Q?3LM7p0XM8i/6P9ToqogpzmgCcJQ47tW+4kwbLKtCRMU2dLx5zuIGkNbW9Bjv?=
 =?us-ascii?Q?FamV3s8qKReKZ0ZEQCIZpcPF6963KUz30IPjtFgnh1cyaW3EbqgIKWXoFcWB?=
 =?us-ascii?Q?YwdM5TUkl0Xognajru4hc0fsQkcgGB/rH4rYpzh2THl/f698LNepYtvaZEKG?=
 =?us-ascii?Q?TCtJSwSNUy5Xx3nl0AWdsUZSfcIZJn3vEdGc3gXy8Gb/qer4OLmkgP5D1aYv?=
 =?us-ascii?Q?YNzY/Lb+WI0iOeFV8ZCGXtLLhtV3Xvymz525mFTC7bZdUFesxUAi1BPBwGZu?=
 =?us-ascii?Q?H8AWY4x3jLX2A38wCnEHbMwSK5yrWH0Ogx6QFJuNRoPIyBXnv9kRwnt9uy7V?=
 =?us-ascii?Q?zLpoSmwhoS6ROV8/D7TOHa2WimXFkcN2/6sgxJhusbBohJlMX81p3J7HeGe3?=
 =?us-ascii?Q?bxGHu1hUUL0Bf+1+2htjGuZmdgup9zCFegQ5rcJkX0sHA1QpZ+hJL42OTnj7?=
 =?us-ascii?Q?v4SX/2nxzdQRqooJPFiwyPhZ3mP4EuZdH1DrfvFOqLep5HwI2pTErAuuvJuW?=
 =?us-ascii?Q?35v5fC7faVuTopygfx1b7jl4aIw+8U+m3In3+KoovTxB1lGxdu8y+balttd2?=
 =?us-ascii?Q?5uf2m/N43EcRP8yO2tU1cHDdjjORAex2uBKEe2gRi9JFzRd8Bp+Hf5p0Zkqr?=
 =?us-ascii?Q?9LNSnZwMh+1JHW2+Cv5e0sTbVdOyoYJKk+z4zuQWY7Tkn65GdT6TrIMvONPM?=
 =?us-ascii?Q?vOp9Yv1fLmGKMgzLkZzzKwIzqQghu6zv5KZ1mXPV9V1NRvdX7EUkSTQerPDg?=
 =?us-ascii?Q?rXTipHzCaakgJ3fwiXthFVN/gFeFnGvSrsIbGr9iq4A0ZWO/fq/hL3/jsObt?=
 =?us-ascii?Q?k6jObd0dCgM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGHFSz6p79LQR12hJoj4vNw8CqKKFtLSsX7SQR8t/AJw3lX8iZDpGNIv7dWQ?=
 =?us-ascii?Q?9kaacWy9T+jiHwk7jfH0YlFXQ1UqHuy+A9GlZxR2V4h5CrUKNEx60RpAQbPs?=
 =?us-ascii?Q?+p7hPCJWhymF0tI+uATqgi0Tznf/1qjEDVpFyNFk3TCoVI7xADUmSQDFRTSm?=
 =?us-ascii?Q?oZpVm3V+wkL/YVu3gKhWw0zdG7X3MYs62jSfVEWAD8t0gj1DLmssmvpqJ1P4?=
 =?us-ascii?Q?afqkhOc26iO86OxWR/pAemHDCmUorI56fkU5Rzo6X34XfcRawzu0StDuHFzs?=
 =?us-ascii?Q?H3tnv/xWCFNuwhuF/HOKdmvD7Te3JKQE8V5offFUnEVOf1Ml6leObltqtWa8?=
 =?us-ascii?Q?isMkkiexEKApez1gw4SlaTz9u96KZKLQ7PDyqK9DHBI65n36GARbpC05FaT8?=
 =?us-ascii?Q?hUt35e81TqL9tP7dpyUEqHpPC9pmjSIB849n9bb0Ywd1wWqXfjZDvPTuwHs/?=
 =?us-ascii?Q?la9yDqv/sFrqJ751gsT5CQrR28h9G4CvCIUgu8ItdPoE+6ZwTQrlGoAa2a1W?=
 =?us-ascii?Q?QQJ3OQuo4/OWotDAnvJEHjA2+SJR5WvWXyR90sXNfjT5UGxPWHMU1jAkXqtg?=
 =?us-ascii?Q?3pzqj3j0kJB4kS4HsubP8jYU+PdFrJXyUaAhSlyLx3yMy6tVYuvAoJMDJigD?=
 =?us-ascii?Q?mhYv0LinLgjeUIS6cvvGJxZwk1lRHgC+XuLLkO8kTd4emnii+3uR03T6KW2p?=
 =?us-ascii?Q?JOP22MJsdft7tvRX/6zUjLmZ0eWr0Db2PRnANBtSGNqTiMhMOSNDGgpfK6iW?=
 =?us-ascii?Q?jK7DA0AHeaM3fDUfV5/he1bOoXuOJP80fde8gU/jo++HkQwbjOwxzKSc2gFE?=
 =?us-ascii?Q?WzB8xR0kCICIFsRoLQ6iHKm2jHUzJbZH3NjXHXsgi2+uS9LJUB3mBxa2YXte?=
 =?us-ascii?Q?5aP2k5pjj+lH0gwd2MVliAdI+YB4v4ugEnQdgGbJObehj3Ayw29YC3GpqP/Y?=
 =?us-ascii?Q?BzwNoKhxdAZ9Hl7sroEQOuG+6/G43BAuKBVoNPJz5j9ccnAv0k2hpAm7qHTy?=
 =?us-ascii?Q?nklS82Y4U1UsLg/smcgbt2aW4G9ZMM+Lco/RXG5/7lwj3HyV/tcb1Eg6VXS5?=
 =?us-ascii?Q?7pcboDBMw4mJU9ZdeFSVfp5vdFxDymPTfV80ON97JmHdarpkPvpfNLtwS7TJ?=
 =?us-ascii?Q?1x1HwwGXigwiHOtJR+ssoCt4DrOjQu4mFNiIPXjOl8MINdJfanMP/iG5Vagf?=
 =?us-ascii?Q?wTygD+zs3ic3d8jakgXcyis4cj8KopiqgNgi4cpIjbI2QYqMYh8U11wnywsb?=
 =?us-ascii?Q?EZwNxT1pPhxuEVkdfsuLHrDJp8+Nz3f6R6Gp8psz+iTC/B126Lz0vJmJ+iZW?=
 =?us-ascii?Q?HZ2wLHhMNXzKOr4umFJ67LwxO/ETuDyoXEd0DQTYb8lFGPxSSXR84T1Oxqfz?=
 =?us-ascii?Q?sIhLwagfJFaHhMyVVYpSvn7AlJgWAFTJzzL/RUgT4sqEhE3U2g3AlM0dMdvl?=
 =?us-ascii?Q?iGl2IyEAotEZdFvMLr3QyAp9B3X38IQYenVIaCVLF6Mo8/aJOj5fVjhT5Isb?=
 =?us-ascii?Q?/iLP/NaZfPOqqrpol5dbXnLS9baQngjOe/wWbnjOSGvRy8tNGIBcOjvK0FHk?=
 =?us-ascii?Q?5Q7Z7wbytEK5wI8vNQyqw+oWQfafjsUsTRUQ/uzuVl8HsZ1j1tX9dnXmznY7?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6070de9-210e-46c5-e302-08dd7175caef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 23:34:48.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9YAXuK19CVfHjyInv0AIHCAiPg1qkhz9tfjlMjydlZkXVHBQFsXshgDYDDgR6Q6VazXHVbMSksJST0572SQXQoZ7CCLBNW0hhs+qj9sgac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Apr 01, 2025 at 01:32:33PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > Is there a reason not to handle more than just LMH's in this set?
> > 
> > This discussion was referenced recently on an IM and I wanted to share
> > my response to it:
> > 
> > The rules for when to apply this memory hole quirk are explicit and
> > suitable to add to the CXL specification. I want the same standard for
> > any other quirk and ideally some proof-of-work to get that quirk
> > recognized by the specification. Otherwise, I worry that generalizing
> > for all the possible ways that platform BIOS tries to be clever means we
> > end up with something that has no rules.
> >
> > The spec is there to allow software to delineate valid configurations vs
> > mistakes, and this slow drip of "Linux does not understand this platform
> > configuration" is a spec gap.
> 
> Note: I've since come around to understand the whole ecosystem a bit
>       better since i wrote this response.

Yes, I should have acknowledged shifts in understanding since this
thread went quiet. Fabio was about to spin this set again to add more
"generalization" and I wanted to clarify my current thinking that
generalization is the opposite of what should happen here.

> I don't know that it's needed.

Referring to spec changes? I think they are, see below

> Some of the explanation of this patch series is a bit confusing. It
> justifies itself by saying CFMWS don't intersect memory holes and that
> endpoint decoders have to be 256MB aligned.
> 
> /*
>  * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
>  *
>  * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
>  * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
>  * the given endpoint decoder HPA range size is always expected aligned and
>  * also larger than that of the matching root decoder. If there are LMH's,
>  * the root decoder range end is always less than SZ_4G.
>  */
> 
> But per the spec, CFMWS is also aligned to be aligned to 256MB.

Right, something has to give, i.e. "spec meet reality". Hardware
endpoint decoders must be aligned, that is a shipping expectation, and
endpoints are not in a position to know or care about host platform
constraints. In constrast, the CFMWS definition runs into a practical
problem meeting the same expectation given competing host phyiscal
memory map constraints.

The platforms with this condition want to support CXL mapped starting at
zero *and* the typical/historical PCI MMIO space in low memory (for
those PCI devices that do not support 64-bit addressing). If the CFMWS
blindly followed the 256MB*NIW constraint the CXL window would overlap
the MMIO space. So the choices are:

1/ Give up on mapping CXL starting at zero when 256MB * NIW does not fit
2/ Give up on maintaining historical availabilty of and compatibility
   with 32-bit only PCI devices (PCI configuration regression)
3/ Trim CFMWS to match the reality that the platform will always route
   memory cycles in that PCI MMIO range to PCI MMIO and never to CXL.
4/ Define some new protocol for when CFMWS is explicitly countermanded
   by other platform resource descriptors, and not a BIOS bug.

The platform in question chose option 3.

> Shouldn't the platform work around memory holes to generate multiple
> CFMWS for the entire capacity, and then use multiple endpoint decoders
> (1 per CFMWS) to map the capacity accordingly?

Per above, the maths do not work out to be able to support that relative
to a CXL region with problematic NIW.

> (Also, I still don't understand the oracle value of <4GB address range.
>  It seems like if this is some quirk of SPA vs HPA alignment, then it
>  can hold for *all* ocurrances, not just stuff below 4GB)

The goal is to get platform vendors to define the rules so that an OS
has a reasonable expectation to know what is a valid vs invalid
configuration. A hole above 4GB has no reason to exist, there is no
resource conflict like PCI MMIO that explains why typical spec
expectation can not be met.

So I want the subsystem to have an explicit set of platform quirks
ideally backed up by updated spec language. That allows us to validate
that the Linux implementation is correct by some objective source of
truth, encourage platform vendors to update that source of truth when
they create new corner cases, or even better, be more mindful to not
create new corner cases.
