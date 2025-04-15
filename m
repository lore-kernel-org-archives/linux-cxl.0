Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1165256C8D;
	Tue, 15 Apr 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752674; cv=fail; b=WrRYFOkgK1T7tRijPrImhT8cX0YXEm85C/jBlYA2HEopzpGYgFPBIIXXn3o7y7A2Iji/9AmeTRVhPM4mJW9IBSN/Ung/CtbLWNwKO4dP09iylJZ3eeWP3h9L7iEx3SGCgCm65/hSB0QFH6n8/AYJHpjV5DgP2Mc0kXJv03Fetfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752674; c=relaxed/simple;
	bh=OYXT9dlTkHuhqtyrmdhGzD9EmDJMfHbJGzmxxya7FoU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKnPjH4eBC3LVpHcSxQjWX2sXAf3TkQg9fS/8Js0licUmq3b6Y+iDmEmc5npX7TnIrCl9+6GQOyWtZpBXp21cmiC9ViZ4Oy09/vJWhQLAKOoMNES4X/I3rL27/OnyoVjzbcyJSPgRrCPN4WpHehJxnDY2oW3PhdaFVQRG2wWFO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hStbORw4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hStbORw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752672; x=1776288672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OYXT9dlTkHuhqtyrmdhGzD9EmDJMfHbJGzmxxya7FoU=;
  b=hStbORw4wrpHYqeCsVAJZFnvdpyZj823vyXXwwDreS4JbIn2mUMu704X
   V2Itob2fgrxY1koaouQip+FXbXH9Xr2noE6nBKnChi5ALMAT1k0cHPKG9
   ie8Qnl3wugmqb5YSpbjg9nCoLlneBMkWg3nBKZkU+NdwKa0i9w1vKP63e
   izbOdBiNTKEC9eeRRPOtonpe3b9H7LdOA7SpWRLVt6xfqIBeCJV2+KT7i
   I+sAVxqTXvUayTiB9gFrXhhR+/lmXGmvpfVhW88LLL6ufRN8AXGB1vPBa
   EpeoKuiL1QP4/TWW3gWeObuQXdfNswd/wjt798D5kn6kvF8bJlzJ4ZEeR
   A==;
X-CSE-ConnectionGUID: +Yv99qofTxSziqnxwgj2zQ==
X-CSE-MsgGUID: OSDaIiFLRdSBjgLAJszFkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56945085"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="56945085"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:31:11 -0700
X-CSE-ConnectionGUID: hebd+lPXSCqRPyYlF6mRkg==
X-CSE-MsgGUID: EvqUGDC9QZ+cp0zO8MqOGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="134355940"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:31:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:31:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:31:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:31:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+fFlhAp258Ttd38VVLtJKF6uQEHwzuyGtBrnKThjCBUZXJUIlv3MPadZHOOhgsR/9/An578+CvHHYW5uORm/5ZLfFC/GeXC7TLN2x0Gkp2VOOYTJ1RMXw3etFrzlhYwL5+GZGbuFsCaEQks9R0T74KXH6h+/De0FNZhZckOQe/Q1POgQIxHKg9/ASKVsYTckTHU97Hjh2dvl350NW4eej0ONyRlxLegKZoO2xHPCOIzUOyhbVUX9pGw/4yYyqugo/ZJ2hk7zyqmWqlWSmGqki06TFnn1FuoC9gVOG9Ly16zzmLh/YvmJhvKZG1wXd7aV/AMFHam81/F6GqClOAPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLcCPfpUzKx6strtRlznC328ujjjCv5B6S37udekKJg=;
 b=rAeh4WsMijWlxBdRhLXdd6Njoqa6aHDhyLG715z7wreTpX5kI+3ar1XTlPmWDMnayc72zqHuCZHr2RFSux2toUrmYtCYVEt6FDlq2U13eZsueK1EGynSO93Q8JwsbNueYTjj7LoBJ9GyLQ8PL9Wz1KHazoMl/1OtV8E45hXnjJr42R87EPP43uaMnJ68EQ2aK6JiaxA83KBuL/n/kzldMpvp2tEQh4YwX6we7ZGGb3BUtv8B1FMcguaf3oi4HgqOHK0lcnptQ6sZB55ADJ+f1P/tIiS0BFI7ReHzW7/KLgPLRSbcza6XJgQ9apiakCHCv61Z9hUkFxGyNNPkIZv0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB8827.namprd11.prod.outlook.com (2603:10b6:8:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:30:54 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:30:54 +0000
Date: Tue, 15 Apr 2025 14:30:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 04/14] cxl: Introduce parent_port_of() helper
Message-ID: <Z_7QCnTMejumorfU@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-5-rrichter@amd.com>
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 8847dd17-3a3e-4b2d-ffeb-08dd7c64cd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hP/qXjq+K2oufdKaCkZSZu5qwc3Vsuf17pZ0DzAUGj5EFkm2t+2cOrIMYPtk?=
 =?us-ascii?Q?gbwJq/Bysw8AQ1VdyOl3d8BmGZzyCciaOIEHzUioqtBIZUs/+Ym5IaV3qagX?=
 =?us-ascii?Q?lWVLdn+NVDVT6saYxiDgEhGJRB/KWEHXagv7gwn+hTiDGlDIIiSCGKM/73TB?=
 =?us-ascii?Q?eLz3RKfmnyO/rXWbjT41P5ewx/shtE0pXxc0zN/h0guoeo5uXRj4hN8OVoDr?=
 =?us-ascii?Q?InufJ1E9ftQyRBdfhSYYwsoUJ+3ucQ7J5zWQU4irwiFvN2X8cCACnR9K6CQw?=
 =?us-ascii?Q?R5a1EaH/hZK6klf/FvF/XjHRlICUr3f6zwVDHtOStaVZx37NOQu2JtDy7fA/?=
 =?us-ascii?Q?V0hOUYkuQBHEKfGJjJj7aCmqCg8tF2zNrBLXl6UyTk9aZj9lUiKIDjoF5xz1?=
 =?us-ascii?Q?ucAEGSRtaEcVQab2WoUmGFqeN/421m6AAFbtF4sUW6XcT0WbAflGmBE6E8YM?=
 =?us-ascii?Q?VuNqskaARhDan60jUzFscLt6ZkeUF8nWDq5zjb+jc/PX9tdlcmSFPaA8Y3rp?=
 =?us-ascii?Q?/oad6eQ2U2nhbXS3A04xTHshZO/3/WDLtfTH0BCwc6mzlC6+g3HwbAGRWsxA?=
 =?us-ascii?Q?ehZlvGxnZr4CnkhkjhnjOfa2nWU1m8P/84ae6M3UHJQEt/QCxHdObKVkk0eS?=
 =?us-ascii?Q?U4PGOSmXHUzPfWHmPbJruxFHa2uIIlazqmUbLqfZIl1E2Y/jTubI0ctfEh75?=
 =?us-ascii?Q?XAqRTHIIitvG5tEkltWTYUFJlkr/Opsk6oVjHks/JadgYCx/+LgO6YS1AEEA?=
 =?us-ascii?Q?4PyTZwEwzqK8uAFLTWlXej75oUovFQy1pOGygVBO0ibsaoLKXhWjidBNYgTs?=
 =?us-ascii?Q?BMFw0kVRQEfZb1jd2/1d+ZUr8bgFTP64JXxUWIhDpThyOSlgYyF5v+q3R8DV?=
 =?us-ascii?Q?Q0sdQ3nwb9fDX1oT4cTypdHTksiOIibtrfSkyHv6n/cY7SVWMrHGh3U768sL?=
 =?us-ascii?Q?qmTxS2rKRwSRP4LoQnfNXJq614t4fRWefUiQGNCDaSy0IgTdnqPsZgmMwuY/?=
 =?us-ascii?Q?oyIF9NkXtNJLD9WGhdnjorlhgvr3FkWB4ZhyvxPGRep1hTDub+kKi2Yf43BV?=
 =?us-ascii?Q?JUhLjFGm/RlB9+bInnzt/EfOKsC7R6UUNMt8d2E09/DjKPOVm6RA9+9XUSPr?=
 =?us-ascii?Q?hmHv/VsUb4dRlBE+nmG3gMKrXHeo80ru5ygjjF+INBKQ3I51NvphPNjFT5sz?=
 =?us-ascii?Q?gIld74fVEiQbqyhOSI8o1nspKZedZrAIBpiKHpAnLP4JdJYdXCy/eZWIVPM+?=
 =?us-ascii?Q?K084wW+u19e5q3G2NHVn9d2xK1q4egqzhOOgRX9aAlMThe+99EMPbNAqZsjl?=
 =?us-ascii?Q?GXbOEcT8Obc8S1OmuTw9bwJS/w7XXdXhNAbQl4ogkcsNZP3qEG1n3pyMosxj?=
 =?us-ascii?Q?bWB7tKkZwAB0YUD9JqOVNfjqgOI2ZDPxyaO5rEUEAFLAbyQZcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T52CxUZsc9v5N/2IiJXVz0PSpTXD1hSdaewmP5qeFv21NhVDaugX41DeHpNH?=
 =?us-ascii?Q?tvvQXygrwFno1Jp9/6VN7/zOAk9RqXK6Sgay6PoQLO/YBQMBgwDJUd/8S42K?=
 =?us-ascii?Q?oBlLrG4PTXnk2azSvtAAnYXYJWo8dSxjzJJbJ8o3AwUsVwEe+EFBjIwGDy0/?=
 =?us-ascii?Q?wUv0SRWzTueQyF7aKJoh/urD9/pWH4Q8ddiHx5js/Ixfnt53hzp6IuNZdXo4?=
 =?us-ascii?Q?agaxnz8FfSd3+vRasei0duxn/ZZAatrA52qQuyf3FI0HYRUJdf8dRADpp3Gh?=
 =?us-ascii?Q?pn5P57oUufBlSKoVBoVnzQvcnAR3SHYKWSBgfXZTlYQHwo6s/fiPiK8cvZBs?=
 =?us-ascii?Q?EegHucPTGhCEGNcjUlz/lSYvUDZCSxeihGKokCAl2aq0kupbLWTm/YZpUyA6?=
 =?us-ascii?Q?pNqkgwZzKfUTaakZEILVQEFQGDkCPQtQ0F6VSMbI9eKt1j+IbmizC4MnfW2r?=
 =?us-ascii?Q?rExxdsul5C6P6MH5pMhoJ+nKwPJpTuoCXbNdAR0t8fKQeSVzX4XxIWR0XfmO?=
 =?us-ascii?Q?G/juIMIyMg2gWprMVWUxIlO/76JRvKdkbiC2N5O9gj5jC2anS+5shksVMhLs?=
 =?us-ascii?Q?37WFmpcOELJCB9fBSOCjvdikoBn57OOPaTMFsBOy+b50+3IOVTLTgoyXluuf?=
 =?us-ascii?Q?7DWCbtL9BhVNvrH+iFTs6KZ9ACEJrKPbm8zHEs538oJjf/3S4XE31XgQUWM9?=
 =?us-ascii?Q?Dw4qYRuOFt/yHx2WRqWUxZ+WJAj1XRAFQvACxzYUqwcR1LyDA5EizJwXvLYC?=
 =?us-ascii?Q?qnrJPdRbHhl5jylK0Tvts1s0mFb/t0qpZV7JbhpYRLwcaC26WENQ1P3JxJYv?=
 =?us-ascii?Q?eEXtfs5rjHmvuX9ZBpJQut4sQuHx1U7btBxGsymjoT6HRjvB+ATA7F8gFAzI?=
 =?us-ascii?Q?A9IaBP94/10G4+9mshG/eBprrWIr02uLRLc7itWgnePCsdZ3eICBoK6VMMri?=
 =?us-ascii?Q?vN3FeSE0NDgovTOnIZmyMfRjI511Szb/L8Iddzr+CsaaRh9OpiCm4tcXgA9X?=
 =?us-ascii?Q?FU8cYEIvOWEZP7P39gVnpnLcYmJyDm3z1Z9g1VaE+pOHPvNQU+eWiHH8qgt6?=
 =?us-ascii?Q?c5tBudenruwqjMzJ985JarODA6fiE1SYssg425Lc3KUGbNwTTeWuvydqeRLf?=
 =?us-ascii?Q?UUuT5ymsQZnbqFYOi82z3DF9X2NAlqKU+W8brP0QJ5S3DofiROuIu4RzECLk?=
 =?us-ascii?Q?TnIKmgtB5qAtnBaAibF1jCAc5dlIj4Xq4/meShxd09LCr4rX3PlAPg3UfjaB?=
 =?us-ascii?Q?tL1bviBOhuKKOw74bfZfICYnLkMw+JvWstBIn3xsgIuuC2S2cw/eJyjqEiza?=
 =?us-ascii?Q?1cSgjFKmpdAQBQhDRcpCsAn2kigdtfDbEsORFq9QibjN3RVQ4vcw+SurNrpk?=
 =?us-ascii?Q?7G7MdYsSvRPHzzEp0Ucjtv0OyD73ZMB24OMiPQuzQ7YA+NYAp3g0DT0yKUMo?=
 =?us-ascii?Q?NKWiaSpiWdqntCQ5eoSYCDM+0pF75SZKR4eCgDTVBuzR3tpvYUjrVBRM8Alx?=
 =?us-ascii?Q?MJXDNBQAWfND5ye3vltfodysoIQXmgX0vQEXbk1cbIu8WZnNh4WuPX0Lcii/?=
 =?us-ascii?Q?ilycbCW/8bWdqJPhAQ1NQ9EAOS1rzwiWXTnijsY+5/CkzIbqtU8ED1WgYa0h?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8847dd17-3a3e-4b2d-ffeb-08dd7c64cd41
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:30:54.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V/xPTnempzAMvtVswtzx5wNCvSxDjwLEf4r0aPLS7ML/AjyXjttkakDrBVxJ/O+l/03ZlY9ALC7bvqsaqw2Dh2c4nCXEonpjC9Vj3kT5fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8827
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:38PM +0100, Robert Richter wrote:
> Often a parent port must be determined. Introduce the parent_port_of()
> helper function for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

