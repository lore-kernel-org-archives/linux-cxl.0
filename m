Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37D3A7D91;
	Thu, 17 Sep 2026 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688512; cv=fail; b=Cmci7DzTIYlgnPoqE900itxzHFRC4VTs2dxU5f+e5pkBS8CXKT4J1vfq04BHTTKCaGOGkbEc4sZEwd1tx84Jy/CGsMpf+meOLIni+bhmjz5tRgwwmkPWUXbBdiDq8JvhLC+Gf2AHdgI+DDuD6l1A/FFWIyRLkUnRnQp/aSVyZFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688512; c=relaxed/simple;
	bh=8V8D16VceCcA1wKgYohIOgovzyOhSxXHMk4FN/tdni0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YTujkpT5lmm1wmsgnyS8NICfoKJu1lco7biKekV6hAwvDxYjrUwyHa5w2RPuA6RaSZmPEPX1IchNKwaIJSJDqwmjWV9oSZmySXOkk1HQ4xn+TtIw40opTE3u2OTVit0l7J8b3XtbPrCCo9viwweulKZRRl8vNj4A+HWOw1fq7Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgapG0W3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgapG0W3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789688510; x=1821224510;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8V8D16VceCcA1wKgYohIOgovzyOhSxXHMk4FN/tdni0=;
  b=jgapG0W3EKTawAOteC3xn594Exy74JJ/zJMYs3LAF6GX6C/Mv55J6BXf
   Stgrh3GcghlAWwLEQ4lvxPrxFFymdo5TNdNgfyop1Q7oyK+xSIraRu9oF
   sjYi6PbtPt4NevETwzJw/myqs4e9RvRTp2v9e4vak3g5L2yaXvTWHeFdf
   /c98Bhrd5Vu+my3iTNuVBIlyp/bHwG62b23b97v0Pxq/m0uMStR/VvBSB
   em+NpNa8pxOCgLp4oNGDUS1hGe5fCyT0cPInwAKiSd6jI0I7zpZVV9oGW
   2U/x0LD+F8AOwiZtbdAZTO6FG0mE+7n53mYZBhxZApWxas7QchL6kAcKJ
   g==;
X-CSE-ConnectionGUID: iRbNPit+RvGQ9IgYXFBCHQ==
X-CSE-MsgGUID: 08S66ubBRo6oBvXQDTC42Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77726170"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77726170"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:41:49 -0700
X-CSE-ConnectionGUID: yvrIlEGpR7CDhX/Pdf/6Ww==
X-CSE-MsgGUID: zkmmuZvPSly6A4oki0kcEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2309623"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:41:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 16:41:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 16:41:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 16:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtQymffvh6354seKGuurDQ4UpRKulAMfp1NXkAkuBT6zxZE8M1mYYTCAI6E261lfgJPrK1e3gJxvgWghKzj0Dy4bZYRn4NZqza5/3vZev4tNTkR0WHRdkhRtuTinT1uhHtJiYkGBcY7DmV9kI/RYm7d8U0ZMDEcXFGgYDL8PSKi9EBrPpXK1E0eLijRPdcY+8OZ4ePgphCHNejC8auwRyOCS1jR+28HF6HQNI0egRO3LNRkevfpQzo7GFagL8meeppbdCuS3e3tzF6Wi0YERPKx/IdSurSOFb6XJHVe3Aoon4YlubMlGwB+ERcyVe2qd+AzOl7jnRgrDSpCCYpdnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LGFxpiulKvzKAbUXoUBKUnyPL/8p/kgpArH+mIZQd0=;
 b=Ljn8rP9ud+QTz8Xqm4b2eCb5uFE/zR3UjuN4NRL3FtbQyVGPl+FYNJ1VL3zEfUiXf21bgd6HH0+Yzij9uHtrKXPyRcGsAUXEGPVuOoLBi9eusKH675tFK+bIuS2fmyMQBeeMXwdLB2RnkVEimYtZv38y4C9/aaTtfS5HCm+zrqFTJAYqSMtw81D6dK6ZgP2T0MkOcBxGgNQdyj8UugmM8oPC+lDf/pMhh+3nlA4de5V8gmPcEmgkDNX7igj4oNPe0J9jtnknqv8G4iUv3+VwcoUYdh8TtdJvcz5Fy3q0zSSs6BPiNE6OQA5TrD1SszmajECvUtBi0PEO3D1m85uyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 23:41:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 23:41:43 +0000
Date: Thu, 17 Sep 2026 16:41:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-kernel@vger.kernel.org>, Anisa Su <anisa.su887@gmail.com>
Subject: Re: [PATCH v2] cxl/mbox: bound the Get Supported Logs entry count by
 the payload
Message-ID: <aqx6rM90rFZEsTuB@aschofie-mobl2.lan>
References: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 914edbde-e691-42ab-01f4-08df15153ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z/USbtHVmsBQg9nayE2Txi9MqkezjmEIZViCUoe4Q8ssT1a6tK3OnmmQFvc2vIJ4G6tWKfsF5wT13KgHz/6NFNvStXpTDPcz/LocRi+2IK+gnOW9q5lZlUYIJr8uQB5l+HwhuI3J/ZMaOo6Nau3ogFMDNHU33jbB7yEB7HRg1/UIlxlxkx/gkhEu8TVxMB46evZk3QYJdyuzSv2M7f98OPHIN5Xuq14OVQO+NbQkTg42ZZMwdae42GZau/GhXGIhrpCOC8NR4zOgcDJ/2GGct5xH6B5llEqY8QJwFHXgpVjwuJRyvUiD8QUgKgNiyMCgF/xjxTGjluFoQ9sAFDrwPln4oS4AW0dbbCD6zZ0t/mbcmnWn+fs2ivEFHfP22RjLzbzjpVH1WCwQD/mY3Dwfywr8p/A8XHhHz5GBroPoIn7gqEcWZZxZ4z6es6swfjvvdTwnDjNQaGznNNW2TBYj7jYLr432KFaaL0cALuiDuj8c/r3X4gX8dl7k3kWDyzS79GDPn8c5SzWE5yuM/JD021QxgvLCz1zaNG1KaWIZFVAJrFDOwEiblnGEBHQ4nsQQd0dfsP01q1D0YhduDcZuhZ/oNQiSafkmJldeSskmHfDcCMhbkhOLdbwlwL/kIld0Jv9VE4V0ltKjutmXRaS1lEUjjZAPDdN3selcfBKItTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4I9H2mgY1PEaDzOK8XoK8/033m7zO5vaCNro0pVdQDovA4vZ888mRlmWcsBl?=
 =?us-ascii?Q?cyEYb4qnOb7tRWX+AUL+Bths+VHd6CNOtdMDcn1feIeg6hGwQ+q/BVYlhLwD?=
 =?us-ascii?Q?7ClebR6JbhMjHVEdlmFAFvYUhBV7J40zsQSnuPdSGp+Z6++F7aVIWjpZhg9h?=
 =?us-ascii?Q?RnfUhtPocum0Vqum6PKnpBP77yN8q97esWPwQ54zQRy9bE7MzG/7lEudbgGo?=
 =?us-ascii?Q?akg8rRZC4U0D4nBe/6fUVVuywJIte9RbELCW9cBDGxn0TWolhJb9CopGfWt8?=
 =?us-ascii?Q?kdoY9ipqMPpUWwP6kxQWUHB3xhn9Q+hVlE/C0hlvjqCJqHcJOlwqnVO8eHdA?=
 =?us-ascii?Q?oL49yzCCG3rQPgQU42/DI7jBnpMse6r67cJaICwqde5gFNcASdwjJaFZ/E3T?=
 =?us-ascii?Q?UU8LqFUI8ooTBeF0XdkymEuuzXkNQwcWE0K+pk0Ntrva14QdWoekFnneNbyz?=
 =?us-ascii?Q?3VbsrmFsnF1F0h/fEiMDlTSD9q4DJPmxpghAdK3bcqxfhlTft4lajK8GUBhq?=
 =?us-ascii?Q?xfcaPU6V3J/+MOwX3pwkgYkfDIHtXhoW4rwZgh2eHv35vaV5+wNMesHBgbou?=
 =?us-ascii?Q?f8UioMwWgsbjJ786K6REMeDYTXnZjV+CJXJ4jLcu8Px1cquOyHK9y5FbVRpf?=
 =?us-ascii?Q?MFYt5fqT6OCPIpjQafQR87yAyO4eOjIT0iAg7I8IzmLBZtmDRGdPif7yyk9j?=
 =?us-ascii?Q?+8bHFzcT5AmBuxLGOdgJuWn5OugVWXLi5BhgvEbXLpGzqGbqcHn5tZQq7/0C?=
 =?us-ascii?Q?K93QevnoXXD/PLTnHywdT2xT5KhNBXfMJvnErZRL/w3OfR5kgU1ha4SZ7iNj?=
 =?us-ascii?Q?eYx1bEwxpOnE1n/sftVhYOgW1YLXQxO0RD5N1FRvkRDt1JfvoINyrXmuylwu?=
 =?us-ascii?Q?mGrWML8jYANfm5Bd1S4wyPTG0T4zz9r/R/Gi6hIKXkZv2uyR7IsC7Oe8qCa9?=
 =?us-ascii?Q?Bv4J24DObEu6ZXreQzjTkMpBud3gxxT+ox/JXU4ujnijDISwSTmxTjA1+bM9?=
 =?us-ascii?Q?x+PMIdkf9AqOSXidO/xwaQuIYBXcZ8oOTl22LocDIIlPPkLNBtV4CTVAzXvc?=
 =?us-ascii?Q?WZ7Bm6F9a4Hdrixz89OuYG3PD4MUDEfWdRbphQenRPiVo9F0i6r71l+cvxMo?=
 =?us-ascii?Q?fgyc7AI1K/vV1jw6SDz5/xT7uY872UM6aXdWHW1Yp8XMMo/Afh6nIBTB3/qj?=
 =?us-ascii?Q?1byeavJtWpjpuhJTxnr7mKzz+iE7lEzhHuEfnjqPQ7J9/uGKzFcfS/GWjs7n?=
 =?us-ascii?Q?n1wItYRAnUvljedpV5es3pT2QPhPIuCVFN0Ey+fJ0+ZYoVUPj/yvdxw2yij3?=
 =?us-ascii?Q?27SlbEsGUKvEtaSXiSnmwW/lq678zJceHOYTlPs+UNXfnzI5qDdckH1rwIgS?=
 =?us-ascii?Q?pPYkNDHymWC+do/f0YSTHJFnf8WMMVDnoA/F44aGWlCo+c/mKG1C12vMJVwq?=
 =?us-ascii?Q?C1Yp42jIG55VUdEoOnHhGzAAID/iC/PqtMgMoCYYD8C23AET9nupadAjdggm?=
 =?us-ascii?Q?bTmtl8yZ3AFiSdxQffIeR7i49JwYFUK8hT0Vb7K22JpRIAEkDNdjBLvKPoxY?=
 =?us-ascii?Q?4lFR1+axS1zzd9nx7SAyxC6PBoSpsWnubntXcftW3k7c5hA0lmULCZ70W8tS?=
 =?us-ascii?Q?6KD6fg4h9XXPTktU94re/8OarA3zw6uuOW68tM3JgyJ3v2VJaB4w0xZfm90L?=
 =?us-ascii?Q?BVwfjotEhrsbCQlCXF1/sc+Isc111SX2l/XSGLNB9cmiTGUUnG9FUn//eRsR?=
 =?us-ascii?Q?gE+IAm7o/89SScvrQVZMNe1LizQtdkk=3D?=
X-Exchange-RoutingPolicyChecked: X6aqsbqhYiVYilB9IJ6/PqP++IZCeuuu41yVZ1v+EOikdaD5QCVh2V8c5LmH+veY9dUcSK1CI/fQhkFZrvX7XFUASjFA0ig4tK08pS18mXxxN6H7orKIHsOBJc2+mAJ06v8WGH1lvr7w4mOaeK+2/T05NXxsQySfYSuarNVmMEnFdjx4nHls+eL4fBjL49k0bCdb4+x55QQvvg1yuW1bIRWaF+0NuURyOM3bmio3MgX3yOpF1TEcJI/I3d2Nm4b70rBfEicPsHRtYnILdJWXczr3/07pUH1yc+/ihkk7/hJnMzim/Y+/1KYAHMQ2MtNJp4c0nI6YOWs+oxScdQI3eA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 914edbde-e691-42ab-01f4-08df15153ab6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 23:41:43.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9x7AXtDOpBxVzBjQJSNhfYSg+TGAgrVqe3XTSs56ok1/Y8rQy4tFAblliHyK3Bhn0H1php/EnwNPab36yzOSyxo8iNbB2x2tfQyuUDeC0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: intel.com

On Thu, Sep 17, 2026 at 06:46:03PM +0800, Gaobin Huang wrote:

Hi Gaobin,

Nit: CXL subsystem begins subjects w uppercase, ie:
cxl/mbox: Bound the Get...


> cxl_enumerate_cmds() iterates gsl->entries entries of gsl->entry[] using
> the count the device put in the Get Supported Logs response.  The response
> is only checked with .min_out = 2, so a device may report more entries
> than it delivered and the driver reads past the end of the buffer.  This
> is probe time, so it happens on every boot of a machine with such a
> device, without any host action.
> 
> cxl_get_gsl() can already tell the caller how much arrived, because
> __cxl_pci_mbox_send_cmd() records the copied byte count in
> mbox_cmd.size_out.  Derive the number of entries that fit from it and stop
> the loop there.
> Guard the subtraction too: min_out is smaller than the response header, so
> a two byte response would otherwise wrap the size_t arithmetic and leave
> the bound with nothing to do.
> 
> Like 1/2, this is hardening against a device that does not honour the
> protocol rather than a fix for a regression: an honest device never reports
> more entries than it returned, so no existing hardware is affected.

Note that once this patch is applied, the text below the scissors lines
disappears and referencing 1/2 loses meaning. Also, I don't think you
can claim no existing hardware is affected.

> 
> Reproduced on the tree this series is based on with a QEMU Type-3 device
> that reports 0xffff entries while writing one.  The 2048 byte buffer holds
> 102 entries, so a claim of 102 is still inside it and 103 is not:
> 
> 	BUG: KASAN: slab-out-of-bounds in cxl_enumerate_cmds+0x1e1/0x870
> 	Read of size 4 at addr ffff8880036de810 by task kworker/u8:4/48
> 	 which belongs to the cache kmalloc-2k of size 2048
> 	The buggy address is located 16 bytes to the right of
> 
> The Read of size 4 is gsl->entry[i].size.  With the bound in place the
> same device logs
> 
> 	GSL: device claimed 65535 entries but the payload holds 1
> 
> and enumeration continues with the entries that are present.

Commit logs do not require this level of forensics. Something like this
would have give your reviewers a crisp snapshot of the problem, impact, and
resolution:

	The Get Supported Logs response includes a device supplied entry count.
	cxl_enumerate_cmds() uses that count without validating it against the
	returned payload length. A malformed response can cause an out-of-bounds
	read during device probe.
	
	Validate the entry count against the returned payload length before using
	the entries.
	
	Reproduced with QEMU modified to return an inconsistent entry count.
	KASAN reported an out-of-bounds read in cxl_enumerate_cmds().

Notice I use the word validate, which gets me to a question about how
this is implemented and the note below. Below you seem to say you model
after get_supported_features() but that is not what I see in this patch.

Are we intentionally bounding the enumeration and continuing with a partial
response, or should we be validating the device supplied count and rejecting
an inconsistent response, as get_supported_features does?

> 
> This is the cross-check get_supported_features() already performs in
> drivers/cxl/core/features.c, where a device supplied count is compared
> against the retrieved length before the entries are used.
> 
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> ---
> v1 -> v2.
> 
> 1/2 of the v1 series (the event record count and cxl_clear_event_record) is
> dropped.  Anisa Su posted a fix for the same bug in the same function on
> 2026-08-31:
> 
>   [PATCH v2 2/4] cxl/events: Validate the record count reported by the device
>   https://lore.kernel.org/linux-cxl/20260901002912.958-3-anisa.su@samsung.com/
> 
> It bounds the count with the same expression (struct_size() against
> mbox_cmd.size_out) and carries the same Fixes: commit (6ebe28f9ec72), so this
> is a duplicate, and hers is the better of the two: it fails the command rather
> than clamping, which also bounds the per-log loop.  Clamping leaves nr_rec
> non-zero, so `} while (nr_rec);` keeps issuing Get and Clear Event Records to a
> device that never clears them -- a hang, which is worse than the read it fixes.
> No reason to post both.
> 
> The patch kept here (formerly 2/2) is not in her series: it is the Get
> Supported Logs entry count during command enumeration, a different function and
> a different response.
> 
> Changes from v1 to this patch, from Jonathan Cameron's review:
> - drop the Fixes: tag; this is hardening against a device that does not honour
>   the protocol, not a fix for a regression, and the commit message says so now
>   rather than leaving it to be inferred.
> - use struct_offset(gsl, entry) and name it gsl_hdr_size so it is not read as a
>   pointer to the header.
> - fail the command when the response is shorter than the header instead of
>   deriving a zero bound from the subtraction.  That also removes the ternary
>   and the underflow it was guarding against, so the comment about wrapping went
>   with it.  -EIO because that is what cxl_internal_send_cmd() returns for a
>   payload size mismatch.
> - add the missing blank line before return ret in cxl_get_gsl().
> 
> Anisa Su is on the Cc list, as she asked on the v1 thread.
> 
>  drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836..e7daa23de 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -794,7 +794,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
>  }
>  
> -static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> +static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds,
> +						       size_t *len)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_supported_logs *ret;
> @@ -818,6 +819,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
>  		return ERR_PTR(rc);
>  	}
>  
> +	*len = mbox_cmd.size_out;	/* bytes actually received */

The comment seems unnecessary. size_out already describes what this is.

>  
>  	return ret;
>  }
> @@ -849,18 +851,47 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  	struct cxl_mbox_get_supported_logs *gsl;
>  	struct device *dev = mds->cxlds.dev;
>  	struct cxl_mem_command *cmd;
> +	size_t gsl_len, gsl_hdr_size, max_entries;
>  	int i, rc;
>  
> -	gsl = cxl_get_gsl(mds);
> +	gsl = cxl_get_gsl(mds, &gsl_len);
>  	if (IS_ERR(gsl))
>  		return PTR_ERR(gsl);
>  
> +	/*
> +	 * The device chooses the reported payload length and min_out only
> +	 * requires the entry count field on its own (2 bytes), so a response
> +	 * shorter than the header is reachable.  There is nothing to enumerate
> +	 * in that case: fail rather than derive a bound from an underflowed
> +	 * subtraction.
> +	 */
> +	gsl_hdr_size = struct_offset(gsl, entry);
> +	if (gsl_len < gsl_hdr_size) {
> +		dev_err(dev,
> +		"GSL: response of %zu bytes is too short for the header\n",
> +		gsl_len);
> +		return -EIO;
> +	}


I don't think the comment is needed. The check and error message make the
requirement clear. As written, it is good self-documenting code :)


> +
> +	max_entries = (gsl_len - gsl_hdr_size) / sizeof(gsl->entry[0]);
> +
>  	rc = -ENOENT;
>  	for (i = 0; i < le16_to_cpu(gsl->entries); i++) {
> -		u32 size = le32_to_cpu(gsl->entry[i].size);
> -		uuid_t uuid = gsl->entry[i].uuid;
> +		u32 size;
> +		uuid_t uuid;
>  		u8 *log;
>  
> +		if (i >= max_entries) {
> +			dev_warn_ratelimited(dev,
> +					     "GSL: device claimed %u entries but the payload holds %zu\n",
> +					     le16_to_cpu(gsl->entries),
> +					     max_entries);
> +			break;
> +		}

Question as above. Why not reject the malformed response here?
If there is a reason to salvage entries that fit, explain that in the
commit log.

If the intent is to validate the device supplied count against max_entries,
it seems clearer to validate the count once before entering the loop.


> +
> +		size = le32_to_cpu(gsl->entry[i].size);
> +		uuid = gsl->entry[i].uuid;
> +
>  		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
>  
>  		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
> 
> base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
> -- 
> 2.34.1
> 
