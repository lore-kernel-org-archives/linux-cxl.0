Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1B23F380;
	Fri, 28 Feb 2025 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786322; cv=fail; b=J7xZtE5By7nlfxWyRLXDsj81UGw64diq75zWu5FTtoAPnBlI+WAWw78sn8p2ferqKimLjaCKqkct/GUaAn5cIiBgPvJ6NlS5B+xyuQBbefkvdSyYyNl6+frvAFNtszaIAS/iQWaNFChUepi2AIW00yoB716g7VC8jj6s2MRVTtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786322; c=relaxed/simple;
	bh=wDSxTzyWsUjhujCE9JFTl4uAK/duD2I6tbP1gLITmgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=urM19BhhKWRWdfMbVeD7hA160dF8JlbRCd/IHIkhBdg34BcNS9Mjr8BH8aOfU4yXZzw2yVWFVADCq+tLJItFyBuELCHWwmp7HFlrEtbmtRvM8O7iiJDMs27FjXjXTZ4p4e9bQV3BKu8Vv9DKDk+UeiIEevxp+M6r1LQ+dxl6eJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loqe7I94; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loqe7I94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740786320; x=1772322320;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wDSxTzyWsUjhujCE9JFTl4uAK/duD2I6tbP1gLITmgk=;
  b=loqe7I940KuGiOsHIA/IlNk/DLf4emPGMkpTUrFTcj/AQGYsKuEW2rMM
   xfkuRSj7hQ/kGoEK7F1WePXuYsB2EcBb4u7N5e2kjKNHSHxcLHa0sIKar
   C/7tSWwijLbQ7itzUBikLt+RjAwJM//n2u3cYaNwSzeiGIHV8O7GOf1LY
   tYmGf/CPlUGyTn3oUu7KyzTMlK19zL4poM6pxMXA8P7TOnIQe4vw/GJkg
   0/o9F3SKVVcW8LFA3Rwqae44r9HqQ6tO+eh06zgBN5ciZHmk7RFGaKR/t
   BeCo/VCGIZIBRoCgUFPQa+H4mCeih1MRDeRw05lYUGJNlfi2ORD+VrCsT
   g==;
X-CSE-ConnectionGUID: uZqxj8pKQgGpuScFf6yupg==
X-CSE-MsgGUID: NVrp+ECjSLeiCxJmqmcqJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="64187502"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="64187502"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 15:45:19 -0800
X-CSE-ConnectionGUID: bIlLzupESY6q+FFalMAJYA==
X-CSE-MsgGUID: AuI4kEvtQRyUPKBP5mxT7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117460094"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 15:45:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 15:45:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 15:45:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 15:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9/720ulqOfilxVnYkDAqNqfEncGAP1P8+iDm02n9TediRSqY3gQvoQ0Q62fEiProD8lx+pDbGxmw+/xNpnqNVDz6yTTXCUzsYNpr2giF0wFfs13Y4LjMperifICzjCFhcUXQSE+8ohcgJCZtdmSDy0tGHuCBzi/lEqYbjMWuNBA/xHlWkhp7+ii8niel3rxcKxbmx+jv7poawsDyRP7XUi7aICoxCtUpzVUP4Y5cgceWfUve1nqbiac5YfI0VOaXZaSqK3aYUGXy2YffYDBoXUKDh5gdIIBbXn+PYRHxZxk/2qifU2ORiA3BdxVtkmPRcdHCkGFnKGacTPCNgcxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqLNtlldYAtrO5LvZ9HFbSmAqLcLZm/bKIePnuLXLl8=;
 b=WqXtxPwC2dZ8u0hEdQdVEK5DvBMlhUT7hwjI+e46VfYFNWYMfBfdgcoIARA+9hO8dVU9tHJGJmhI9ikjogM8tzgHOukLLOEj5WggV/pT0kmtbw2QIq1DaJEXs5TtdSqeSjeMvF1AD8i9dksx1WDMxEUWcIjassBoUt4zaGVKc0t5rEKImTOij+ONmP1PtkLQClyJZ5jvfSnLEllTT0Id259OMUqPu5ix7jADx715/SYfj/CFD0gV8/XYu1+D+AzrFUKTL4wj+VhkHkfHAIo3YX8p2pLsKfnyPXkHr/TIbCTP+is0tUzdjHTAZEcd9xnWhYNw5SEpDeKVOzthizblLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 23:45:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 23:45:15 +0000
Date: Fri, 28 Feb 2025 15:45:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Li Ming
	<ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
Message-ID: <67c24a88bb358_1a7729481@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250227103251.390147-1-ming.li@zohomail.com>
 <Z8DdafbX6_tbM4DW@aschofie-mobl2.lan>
 <4c97ec3a-3435-4e79-8265-6a82ae930c3e@zohomail.com>
 <Z8IBuE714QNscgfJ@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z8IBuE714QNscgfJ@aschofie-mobl2.lan>
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 5969dba7-14fb-4c97-842b-08dd5851f30f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W+EWlMBA1VDzLGbMY7HqYDEmOnU5l09yKWvPz+bPGdNyKBsbQ4xpEEXUFmpk?=
 =?us-ascii?Q?GrNs40HBweiVwatnN70ibybYyZ8Oip/6n2uEDMTkthmRb8JpWWjGjOBhBztW?=
 =?us-ascii?Q?oBV+5OKzn1Daf0vyfBfZ6rIdMX5owZ8/GkOq0kONvdsXlUUra+mMW5YAzgNN?=
 =?us-ascii?Q?DaIjwefo/vH+49dps7YXyxJQTeJePZc4tOHdveqSks2ovB54c9xa9Eizs/Mw?=
 =?us-ascii?Q?3xmp4lM4jyQ8oxOxqzVeqyiKsm7+9I1kGRzqGYhPfgBonFs7sPfz0fc5HH/+?=
 =?us-ascii?Q?nkPMVEqtnbZXaSHAxAKuJ0I07tgLFSHDtFbm7d26P0qZFPN/dJwxA6kjdzB9?=
 =?us-ascii?Q?vyubKBI/ZpkjXjJqyeg3yL6L/Ln1BtFW/N5xUl3c2crXR+2T/He/FmiIXv8B?=
 =?us-ascii?Q?PAXv2hu2/eLvyGAt6qzO9uqozg4Ftbc55AjLeCztDw+MpJudCNtm2/rNh2XY?=
 =?us-ascii?Q?4sOL9A8iaUnoXGRtMqubSw7GRNbitmYjtwqH9wVIdQBKyDJnmxEKBBuMjBKE?=
 =?us-ascii?Q?AJvF4wgQtEwnt0okxAYUwSzp6SU33HyUUMgQQg3Ab9nvDkH9o/CjpIFVJ9a8?=
 =?us-ascii?Q?Gd16PRi7Qzyk+tLG+r95bqjxfafOZ5hQOB0TN6AJmpYxP+Ic+MajJQkIdkSi?=
 =?us-ascii?Q?mZowEKUa5mDTtOIc0I9Jf1CAaemahMq1cj0LEkCABlHa1H6Nh6f4q4b+Hlnd?=
 =?us-ascii?Q?JwbMRy7gIgtgok/e80in6+dcHq89qhiiGpldsOZbixjZ7DZ9QHe0Tg8S87/m?=
 =?us-ascii?Q?C30XdpojPS7J01WHhWa742ZO5hqF+O/ujl+w0RuYoYgCslkQ17i+2dlWQXRP?=
 =?us-ascii?Q?jzgv+TXgSHLbk+XcTOlH734z4zpctvlQx1vmfkWlV4uhRnMniupO3aURF9Y1?=
 =?us-ascii?Q?ijg1BsucYFkqVxtRevoMKI4QbhMKf3hMRNL2BzXgl6lNxW4Lm9CXM0AvNC1K?=
 =?us-ascii?Q?upfuG62aF9To1GWzPE29p3YEjW+7w/V5KQvW7A+vEtRfdmjvoVhsKYHIfmtx?=
 =?us-ascii?Q?aTz2XPd6+AyS1T6WuD4tMLwO5kNBszGBQFaLdx5d+6z6vejV8iiVWKyNTdAP?=
 =?us-ascii?Q?6xhtyIV0J0Z1ewGwvFV4FYGaOB0Cbq9RYAQaC9IL+AnNz0E/ws6MTUchoqZu?=
 =?us-ascii?Q?V5kR/J2obF3YxyyZMtGp9sNLdyDiLaqgpCzEG4GPzpHmMnUFzZrMf/kQTspQ?=
 =?us-ascii?Q?5+gyLhJTVwUoala/OTTHb/jyxbpy5bVCmg4FjjRrBUTuVDCzUrGssAI/8LD3?=
 =?us-ascii?Q?nyJ09zhRIrLSe2Eto0JRMoqDOC4HMAnuq8Zspy/xzp3HkNlZloFeAuKZpS+I?=
 =?us-ascii?Q?N55NpbOvouDtUDP7PY1CiUFdmsspUxA/ozr+xmYnkcT47AWXPouV/j2KFoB4?=
 =?us-ascii?Q?fWNwcIL0hMw11n75FKx/iat8eHpy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llitr5773+PLES4GTCY3Y2CnUEAI/QbGY32jpg9X0wfw07EUD+fGflcTSqTa?=
 =?us-ascii?Q?CDnpXx0BG8p0JByzFiqGdQ1MMTIIPFRUEPZIhkJp/vFonWf1ws+s5gNGtB2H?=
 =?us-ascii?Q?r6PXdxXCuz/T9gRWwkHoejxiepqjQBnJZZmZY2docDfn+/6Yt109FZKtq6HF?=
 =?us-ascii?Q?yOY70/sUpHDiekLvP+UH4RwdfYlUS6PdUrqaxhOIQ+j/8n2X7ct6eX2ZGwBF?=
 =?us-ascii?Q?U60Tdx4Uh0DhYItDv2K8HzQUnssDiE5uxsYNaRIi34iJ7x1Ol14EsymkpSfS?=
 =?us-ascii?Q?LZ/bL3ju8SIW0m9YLlkeRKVY7fTOvX32VTwViQpH+xf/qKWZ0KLfZsLui1qS?=
 =?us-ascii?Q?CFcfn4xYbqAHhGmX8q9bBshkx+DvfNGuSR0CrdurNGX0nmLJa9Dp9AUmf8FN?=
 =?us-ascii?Q?zlt1oHPatdKbrjnOPrClYXDcZQ3JcE94/9Joli4zPEJYlYe8nv1RlA0FMn7A?=
 =?us-ascii?Q?NCZeiDD2mLfRMg3anNjESb+ZSHOCuEKj/40K5YDy5XSUPXWwS/vX6OKAtUYb?=
 =?us-ascii?Q?+AF9gheuybGPyadkJJ7Nff/R9MSMNlWBefmmyXl0z7SSsToJ+GFZ+DAXDf7b?=
 =?us-ascii?Q?4uUSosOzWucQwnZ47j8ahjXU/Daqv4mRWU/S3iIr8Q6wdxs+mY9IveQ65P6H?=
 =?us-ascii?Q?COpc5L8YY1mfl0N5r+VAt1kLk3O3IfDel6jcCcu5kL9aWpeKpPnYQBPSt4Sn?=
 =?us-ascii?Q?Z+8ygrJg7xIna8wvs44f9w19YPhDygmIKB3yZUw543SaDKEEbDKEgDq5vw5a?=
 =?us-ascii?Q?GdDARaUELnMI9rl+kXQ9wocEJdTb5Q1yOqgSHJGzovGI3E+m7Ob0nrULe1Do?=
 =?us-ascii?Q?xNAl26ZpLa0kSpufXgbMVgHiRAlUlhavbuLGLTRVoooyK89qMi4ARuejfIsu?=
 =?us-ascii?Q?JHAfgMu2LZGWU4vm1vyGlD3S2UKF3WO+Or3QSLg4H0eJXPDryhxkHYTquUh1?=
 =?us-ascii?Q?S9/fwxvXmYV7VCfTbSDUGdPa8zEAmhhLrMRk4Ob1ObTS+WrJWUY4yHZoHPf2?=
 =?us-ascii?Q?2HiXyd7oPvaWdJQWTSGm0uTriF7fnOkSNchbFqAuoLOzkWDl9zaH5N5gIP3x?=
 =?us-ascii?Q?IDmLCMmN53a3Vw63vNw2O8GtWfNoO9ofFwMTSGz8emUTVgThJy50PXXLuztQ?=
 =?us-ascii?Q?wJvJpaqor04ttNRj3wvmH5CczfOmges5CtBfByJeC6w73u9U+cNOCe/P2RaX?=
 =?us-ascii?Q?Af4QNVvFnKfYMcUvPcQeppQYcHOCFWNJkrGfTVuqVYdY++0qPotzVA8JD4mY?=
 =?us-ascii?Q?5ETI7Rd9DZApyPn9p4ll3CmHI3SE2sKvmyT85viLvSoa+8/80GlNQsFg9xOt?=
 =?us-ascii?Q?TWwHiRcW82wjGOO2simSZcQqS3VaixK9DWUXQv3vStSU6gY9JdvvS+rv47/M?=
 =?us-ascii?Q?Ra6Ao8nOmrlXu7DKk0Kieka6gvqHfLRAgI0ZGB1gSZPR6DQ0El0yKoUGTugt?=
 =?us-ascii?Q?Ue097T7+DgCydNT8e6zHGT+i7sTLKlnnxx6C0PdJgxF0SYLFZpwPJTxkp/sc?=
 =?us-ascii?Q?XkxWQhzOXZ0eOQhVtsxEUUAfbE1yLwCB4B2OG9OtlWVAXSX8c9SU/MD8yJqG?=
 =?us-ascii?Q?7aHNBy3EcccvVq5Hb2wSCvqQvkwC1xWsMVtRbeYQ0W+V2o6UljZ6Ki1vEVfR?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5969dba7-14fb-4c97-842b-08dd5851f30f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 23:45:15.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H33Wh3Dyz4tx9F8f+BHJEkt043wTpRrA17DmukJGBGPRAS0q2/QXV9nSodi7hL56FM9U9jsPvNIw8a0DC+3yaZPFfaPaOxpIDeBQ2qsCsX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, Feb 28, 2025 at 10:47:12AM +0800, Li Ming wrote:
> > On 2/28/2025 5:47 AM, Alison Schofield wrote:
> > > On Thu, Feb 27, 2025 at 06:32:51PM +0800, Li Ming wrote:
> > >> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
> > >> decoder capability, But according to the implementation of
> > >> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.
> > > How does a check against the spec maximums benefit this driver? Is there
> > > a bad path we avoid by checking and quitting at this point.
> > 
> > 
> > My understanding is that no a bad path on driver side if the decoder_count is greater than the maximum number spec defines.
> > 
> > Driver just allocates cxl decoders on the port based on the value of decoder_count. But I am not sure if hardware will have other potential problems when it didn't follow the spec.
> 
> I had the general thought that the driver is not responsible for
> compliance checking the device, unless it affects function. Excessive
> decoder_count's sound like they cause needless allocations, so let's
> stop doing that - as best we can. 

Only if we see a device in the wild that causes an actual problem.
Otherwise this is a losing theoretical game of adding checks for things
that will likely never be violated. The way to address devices that
violate spec expectations *and* cause end user visible pain is to add
quirks. The allocation of a few extra decoders is does not amount to
that standard.

Lets not add checks for benign issues "just because", or "just in case".
If the check is cheap and we need to do it for the driver's own internal
sanity, fine, but if it's just being strict for strictness sake, please
no.
