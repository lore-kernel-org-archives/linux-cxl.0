Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C81B813;
	Sat,  5 Oct 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149013; cv=fail; b=AXE6VzWB/AmVlQl+cGIGUyrtpqXetjigez1AgJjDdm+JX1qNmG0YWGmjmY37nwBBOGut+7xR9756/yXaOQN9w1c/Za6JQ1jxV8vXrXmxd1721loCNx2KeI0kZHHPiaWvtgceIFpe0NgLwEApsj42MDR/bYT0JCQv5C6UB1Vc9KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149013; c=relaxed/simple;
	bh=PVBKuUvoBz3I/VSSaXTm3LLc8iEhrpGDo1wegxMtgqc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rShw185pX9KVj+JtQJZbE8Wr1zM44UJ9e+jue2vpgBn3v8OfuETeF7aDDZL4k3gYKtuqGtxDA13k/28hL10LdDdujvRs06k6pkGaWLpd7iA4gl3E3eANtRUQxj3pTOS7xuNpWZRmpI2tkxq2rUnu6rzRhMt13dh96PX1r0UA/18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxX72lwX; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxX72lwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728149012; x=1759685012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PVBKuUvoBz3I/VSSaXTm3LLc8iEhrpGDo1wegxMtgqc=;
  b=nxX72lwX9OLtVRjPdZU8ldA7VsTqdMIAJvKx2tjRMolrYv9Qe05uc+eg
   vJ9c1BHnxlCRuEzEItogNBsO7mrBZSqdy4v3+wnFaa11RE3oIkeIhOrhD
   rSrqcn8yMOklMOR5Vt35I5pakG49pARmT71L+a1CZYMAOk/BWzV84L1lv
   xzVJKrWD9OqLH0kfUGRwmpx6SmiPGFN/iIyMncUK5nY8m3Cxr4vzZWi47
   mF3VEs0+Pe8AUwYuLIv0ylnggDp52/bBoPvrgFgmf3X0YdwbswDl4Q3Zm
   G1DmMx651nCsQ/X1STk0pUd5VPISKSreLOw2MveHTbNyyMdqEdD6uEpMn
   Q==;
X-CSE-ConnectionGUID: HKK+xaYaTSKKLTSirAZpww==
X-CSE-MsgGUID: /HHvTPcbQ22JG4qLoEDLiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="26851762"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="26851762"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 10:23:31 -0700
X-CSE-ConnectionGUID: oXOCt5SqRtuNIRW34K3B+g==
X-CSE-MsgGUID: AVok5OUlTz2CybSsmnSrfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="105775131"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2024 10:23:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 10:23:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 5 Oct 2024 10:23:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 5 Oct 2024 10:23:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Oct 2024 10:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvUEEYbzSWSm5WcTeJw2iLkDPtv6f+wHWh0ejxul3b3xFAYWQAjKoCpk5h8aalVYKZzc4zQhgt/NAP8lzALmrtwgJChjtI+hEa5lAt2jnOb5KFAT5Eea59hqpliunoWwvCfEyjxQGTODZjeo2Eqk9HRHa09vpimhNKaU/NENWvfVo6s3zFgG3zejwXPRTGQDiZcIirB9at9Aq90e8+6dRXwUJpmevDjZhOQvF35f6kgF6CRS7SRu0UocgeJ9xxSR0rQoBBmImAKaX49flkVy+FLsztmnxJcodPwkxE6XrY8dnGBi5/2fheoiPv4UdM0gu5kXyCnVXqcRVALgevoC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPD+AJYSo1JsiPkUwVaDdbxB6yl2eYIvt/GyovCdxVM=;
 b=ZR0239S0MS13TkvyK/PrJ8GVThlttCnT2BbS6pdB26s9INSNj4uULQTCW9szg5OGGS6KuhCU+ZTX9krRhDelbUZphXmFjM0QR/pCMO06l1rpQJ7RgmhlAC83JCoWD8Anx+GQsesu9h7hCerAis89x2WufhS66xdJ2RgpZX849N56GufNcqnMqWHvC4+fstGQoJ30RtpCMmOL4CAVmw8KWv0lYLU+g/fNS8qZ06k9/rpvOaGQX3JNDSbLZyE7n/uabSF7h47o9J67C/2xHYt8ufZAVZsX6gBpMplTXe47q1RB+LjZmzTpJP17SLRuD2Oyv1aEpB7fYuf08Xtq/f//Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 17:23:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.017; Sat, 5 Oct 2024
 17:23:27 +0000
Date: Sat, 5 Oct 2024 12:23:23 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Srinivasulu Thanneeru
	<sthanneeru.opensrc@micron.com>, Ira Weiny <ira.weiny@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.12-rc2
Message-ID: <6701760b2e390_16041829420@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdb1d99-089b-4542-7d78-08dce5626cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LihVaC46gPpdevVPlUO9E+jQaq/DBYhAILxnnKAPN3ldgBA+IzwcnhN1FtKT?=
 =?us-ascii?Q?sBYhweeS1c7Fc17syO8Sk6eCMhot4qF2TelZME26p2MEkawpvFh9mnUeQi2h?=
 =?us-ascii?Q?xhpQqGYFMyW7bPf8AzxV5bxjaM8XmFbI0Fdn+4K2H1yLDh+yU17E/4+tnFji?=
 =?us-ascii?Q?FltQnzj5Yp92n1Rubl8NklgtFjuPZV6HjxpupscjosPP7A4wrFCkjNFxTV33?=
 =?us-ascii?Q?FusyU9m8bOrUr4bCgyDVCIDDCs1E6uqDgoAba83gCCDy2JmUxS+L4h/cbeXT?=
 =?us-ascii?Q?aPpdclI+4AfzRJJszLkdPT0OdpzhnGJpm/haji74JiHrBfFKeRiwyfM3qL3v?=
 =?us-ascii?Q?IZhjKZR+Ig47zlUFQvBQ0bAcbgP4oqSxfO4u97WY6KWPsJSAT3rbJDvHb3EV?=
 =?us-ascii?Q?V2zJiSmj0Ahbr/gOeRk0UTD5XM6HF7Mr1a9CJcdRBjcB4NVlDuqNR6qHLOt/?=
 =?us-ascii?Q?OOh0F5OnAfx0P0UlFdkpuxh3niQi1VtdcV7QUFi2A2B6BMh1tKMx9M3bMwqv?=
 =?us-ascii?Q?PxW2FVx4waLFrNd4icVL6dWGaYxb81NQy0V2LbVifrAq2Cofiu1hGMqk58Kj?=
 =?us-ascii?Q?vTzewqrRCHUJJCEsTMUpvQuGsu3Iai1BSYyWJK4GT/eSsS4ElLFnkWIa/SA8?=
 =?us-ascii?Q?dM1dcsztH6CmaIRGXDT75cv4kEU9vhclpHkykGJ39tpELc4eyaNO+uTJHefb?=
 =?us-ascii?Q?fTIh/lfAckLCfHYGfXWPrJRS3VS4ZPhTa3QoO70ne6tL5Sklw2+PfysZIHp9?=
 =?us-ascii?Q?NW4wbt/lzCZVQQMmZqeHVCCtTlr1g4b9A24NhTYr6bsbB8l5e/54WpABWhQ6?=
 =?us-ascii?Q?qbrGjSgIdEuwNrUwO9ORybfAnU/JJUS6Z7BD+dOmM59h6DgTqn7kZRFAHUxX?=
 =?us-ascii?Q?PDsBXxZxAm4fxJ080JnlDGsSewQ86ufIL7IpFKA9MTvHJreLP/QFS57Wu9vI?=
 =?us-ascii?Q?2ZhTu9OH1VA3sGtrKttO3cv6gpALv6SY2Lcpoq/1CbbKimaZMi0Rq70WzlvJ?=
 =?us-ascii?Q?IhlrWQUFyiTDimAWemcqjf40uCerjZA0mtdVvK3nFmGukPBDfQMzggt3htK5?=
 =?us-ascii?Q?vkKVGJvIOLbe/v8aBgP54Dz7bqcsk53f2TJ4rLBRA5+5zXw/CW1WpJd6wIuD?=
 =?us-ascii?Q?1ZiobrC9ebzWhxoGurIWTF9Je5Jo19X4RHbtagCy2eDZ/kh420BkcyICjOV2?=
 =?us-ascii?Q?KkQWkllMGhlumF8CXVaQvZYRw4Xw+PRa5nQF50K3HhO7IBovMTFWVsTLIVAo?=
 =?us-ascii?Q?zZEhmPscN9YVw3ITUL/ppavPxTMOmyhNjFiUEoT/VA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xx1Mn0sINm2TTHg9n4+g/iBCbjwzHT2Rc66wQWS9W16Wd+hLaosD7itgs+c?=
 =?us-ascii?Q?H9I8moFGOlvGBmnE6NFuExaS/GnacTzIdyLitkU9nIL0ygh7R2zsHhBHzECh?=
 =?us-ascii?Q?ctmZoRETaW8Hg7N7+CzEnaOhmgYpooO+3foKkBlDGsgJvrrmpdG6SMzYdz7N?=
 =?us-ascii?Q?SZ0g1jOKF6gyN4o3rhHX2rkADFzftTD6TpjnoO/enXSpTo7iz3uETUxgh0ZB?=
 =?us-ascii?Q?oBbkmb/m8EfP0Sn6xarQWUdcbcdgrYJneYUhdsLtsuhTFNucjCPhbMWBG14I?=
 =?us-ascii?Q?LSwE8Eh29yM1KupK/gfWywN3OWk4bMDgR5ZBfgqcGHIG/czqzMFK1gXhY6rP?=
 =?us-ascii?Q?5dNJxmazo5k0PPWYu3/QWVnmWztgdPM5CpzTx9MI+xQxmcmDn6idSY6Ifugq?=
 =?us-ascii?Q?7sXxmWAwxc7Uh1AAebp7Q5/mIeZNk80ImiuwZRprFjBEPCEKI0yuj4RxlQ67?=
 =?us-ascii?Q?GOXE5meUQQbaW0/zZZlL962WpxcYGxRDF5Qa7TpLDrGrOhySLFg+zAqDNHv1?=
 =?us-ascii?Q?DZMtYNLz+w8xixxUOc0J7uAUBdkZ4ZPY+VQrvjN5tofYJBYpXii5huGUsST+?=
 =?us-ascii?Q?VN3hONbo2aAhpADS0d2v8tRMbCeUybwTw1PW1vu3Sz+zROBR7eXSWeZYmmKg?=
 =?us-ascii?Q?JEpzy1nr05yyEcrghCCKb0ef/jeSKZUu/CAk8cUI12M8IIrMzQ8DLQvmLTQb?=
 =?us-ascii?Q?ImuNCY4LKYXJ/PuAHdMDioVHgX7l7w4YsjcW5vLVI+GIRRV2iiwXtInCmiA/?=
 =?us-ascii?Q?14HKFLg2pQo3VoG44b4A+fAsM+gUYTVBBnH1bGbprnrrmJTcguWS/NFcUBHp?=
 =?us-ascii?Q?q0UUZDWi8mAHjh3YFEXVS7du+48jdkF/p8/7CLctub6NCuH2fbTHoT/8nvEh?=
 =?us-ascii?Q?wJjVWe9MaCUpZY8pdC/4Eesxs21D6KJHZcVMTuQ6lvHXbJGB6TXLCFcbdp1v?=
 =?us-ascii?Q?9ts0fLJ519JVzBGulKnaQ/K0xS5gPyuSsRSXBCks1FSNhrG5FbID1NjYZ6YC?=
 =?us-ascii?Q?awNYEi6fqBQrbq50QbXlrs7vsp3aX/XoG8BO39pWSWH3qJkCRaF3aP19GR+2?=
 =?us-ascii?Q?xAC39MAn0huvaVSS6cnWA9vbo28JSinION8aLYyGioq7KwrBgZ6SPeQOZiV5?=
 =?us-ascii?Q?nJGoN3E83+yUQCGaWMzkGDHpGcFY5p48GJal1PH/gLDvJ2wHXftbqNpaQGt2?=
 =?us-ascii?Q?ObYzdvEWg+FmzLMV2/AFJc6GpOyPjhC80/pqv7XCtaY0RZtYSs1J647rRQ8i?=
 =?us-ascii?Q?GeJeXuwaszFHKOK6wgIWNK+BO830UvCQjosiOEmyqMja+Y4uy/nCMHhTfda7?=
 =?us-ascii?Q?KlBEfKYP+XwI8byvCszRzr+aEBKf8DDoIngo/n9XckliAU6DiYtnxFWCy2kH?=
 =?us-ascii?Q?NFxuG0nst+Lw+XHWuy/xZjLURpags4FvzaIE/gHLRyBbhHG3drvwHdRuSxx/?=
 =?us-ascii?Q?VcJ+JzfVjItun774y4L0wYWooep/3gSnKOgc1KDCFKKjlcladqdf34enRevl?=
 =?us-ascii?Q?FlzAAbP9IAfbf3kSAXFsuNi4MUwBRB6AXj9DgPkazCCFasc/NeeamlPVhKqi?=
 =?us-ascii?Q?em/98nd7vg4hk4R3WX1Os6TcZyegUGe5qEiMYw3E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb1d99-089b-4542-7d78-08dce5626cef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 17:23:27.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zajdu7yQIVnc3MxhciBfvVBnt3kmv65tdXX1pTChbmD4fTqnjiJfCPBcemPTDH/fTp/KcCuNACbez8M3nT1jvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
X-OriginatorOrg: intel.com

Hi Linus, please pull from 

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc2

This is a small patch which fixes an older bug but was missed in the merge
window PR.

It has been in next for a couple of days.

Thank you,
Ira Weiny
(Subbing for Dave Jiang while on vacation)

---

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc2

for you to fetch changes up to ee1e3c46ed19c096be22472c728fa7f68b1352c4:

  EINJ, CXL: Fix CXL device SBDF calculation (2024-09-30 08:10:39 -0500)

----------------------------------------------------------------
cxl fixes for 6.12-rc2

- Fix calculation for SBDF in error injection

----------------------------------------------------------------
Ben Cheatham (1):
      EINJ, CXL: Fix CXL device SBDF calculation

 drivers/acpi/apei/einj-cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
