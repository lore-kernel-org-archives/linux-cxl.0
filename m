Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB1197548;
	Thu,  5 Sep 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572235; cv=fail; b=IZPSSw0zyC2nki/Q3jk1b67n+WKIVyZH3x6F1KJIS5Nga6aufuwctGQbzFxzYbdWu447e4w7pmw7I/XGsP9jkCod6ar3pjgGuVjkCd55YM9b9qPKGle/PSEvgQX8UxpfhtbjdwnJpRdy43HjbcW8qAnWXlmz5tnxIwBoUltF71k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572235; c=relaxed/simple;
	bh=pFw1vPjpTgtFRPtZg5d2ufGTIKrvF/CXMTeoQip3LTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TeDZxECvl5S1u70pJkUDC9bapu2FmczDW8FQ7JKDlnw5BreghyERpgVJdjADnsNJ/XfxmIH2M3QRsjuVPbyt3iVCZj/IGzwNrO85fNtIDvyZOISSouVY5HBlIhRBdcNOAf5xToBONlB7x28L6BLaOBLqlVo+bnhUY0K9iwH+GuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZXyEK8Z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZXyEK8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725572234; x=1757108234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pFw1vPjpTgtFRPtZg5d2ufGTIKrvF/CXMTeoQip3LTg=;
  b=WZXyEK8ZVGenAIoEl33y22pj6FH9V6/f+u5uH2jcGaYnxQagu6e38XSE
   Qi0XcbtmoCFWeNbnNfmIKHss0TmwiuHhC56EtOLdJUVeekjblsFaFRud+
   Xd4F5IKNin65lKrUTLoBCO+iwgxBB25G4ITQTdlqr6gzqdRAf6zrg/k/D
   XMlNDKcZ3+RErmtbFVS4+h6wES9LWIWNd4RJc322423rBlnebhoZNbgd6
   Sq5+kw4RIzgzNyI+kmb+6mCdQoXXIU6g9Bc03qOmHj8c3A774w8P1WPuy
   ZkgqhN098JFj0Ai2pp7VK1ejQiJDdypUgQ30dUjyo92FsR7N6Wq/iUJhj
   w==;
X-CSE-ConnectionGUID: FNOYoSxKTlOlcEHpyfMjSQ==
X-CSE-MsgGUID: v1hLN4meTFKAhir9A1qqaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="13395550"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="13395550"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 14:37:13 -0700
X-CSE-ConnectionGUID: ab7aJ6oFTNWJ0L8Zip0I3g==
X-CSE-MsgGUID: 3hPA47mvRSuDFA2WWyBh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70558305"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 14:37:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 14:37:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 14:37:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 14:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY6lSh7fcmAseQ/5DtzPfqxFHlJAGLb/oLxEebMNAvpoGteH7ZNG+Cx8E8JH+VqSfVL17shmJKM//4usS3zJ9qUwOPzPt5hvbA6HCvUFLARCxL1b2oVMU/h1ACB/vZjcRFQ9b/L+bQCSq1ElHYU37TYlqFL7aqqNpQS1kHNABExos0p2AG92Eqy0U5QTRj30xAGThnFq7S+bwcM+MbtfOGK7I7qqtRL/ycUFAvaZPyIh5nsB1LUk+UwSEbCecECaGP4h2HrorJIxRXi9f7l9lTRPZVnC75plCz8YCafGgWCMFHVn8XeO+dbwj51mWQH0BhFjWKUGqrn1l9IBTBT3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eOl/5PusILXyoexG8Kkjoj4YPl9OVgzMW2FA8zxdAA=;
 b=wzHo7s8Bjkjx/ufCK7J5iqgyJjBT3geamat4uzoDFHr+Cdp99zpJr1+y5EIsYxNyLLxJ/UpHNooAYlQ4rgCecv3csXtxbDmD5DhrMHWU393LQD8drzVVeNKbnTQc6CCJKxMZR0mJxnS0AH8tIgaQIPYwIMoEhnbzCDZN96AJKDMT3MU63hbWD1nQ3Ny91rwsuWASBJP08JysLnj86lAIiQKEI6C9Aig4n2WOEps1uNvY0fGiwiFBC9JtJZm3rND3EM3CxnXT0YuXwlXaYFGnS7r2U8nuQDSwRr1NWLLtYqwnHEgKKg4ybnLMYIaRWcfht/MUbajqJU4c1fDdWhYc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 21:37:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 21:37:09 +0000
Date: Thu, 5 Sep 2024 14:37:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "David
 Hildenbrand" <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Baoquan He
	<bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <66da24827b2a9_22a2294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
X-ClientProxiedBy: MW4PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:303:84::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3485287d-632c-4daf-c581-08dccdf2e54a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGAflRvLwEGAaQSgaQz+zTpK15a/cQ80vXGck/yEopIPsR+1bD6T6f6CiWSJ?=
 =?us-ascii?Q?T1utNrmg8H/XHtv4sy0AIpJQZiqgDFBuYuJDrTwlGw7SsspO1OMRtuA0I4ut?=
 =?us-ascii?Q?Aosvrz7cGnhrqD6o/sIHTQm1gW9I2FE8K0qwu4A62cDUlx2DkShPT5rkjA3D?=
 =?us-ascii?Q?829x8Upc7mYPrIv5JZlynIrKLV01GOoVA2F2Qu5Ma7rWDafMmFrpcPkKaBXH?=
 =?us-ascii?Q?6A1iPd72FUqzm8ZMPU24oq0/dydnSMcyJWGzFK3mFYLr9/+UDu/rQWULDs5P?=
 =?us-ascii?Q?52Y4IaRxIPV9ZU9t6nKO0J/QuxQSU2AfojOBWsgpmQJEr5E/FKhq1L+AzUVo?=
 =?us-ascii?Q?HEtuYus3x87MXSBdE06rYJZAmOjp0N5bev2EWHZzfTtr8EYggnXdkm0O4m9E?=
 =?us-ascii?Q?D0JJozaMFnF0xUaWtjGnK+oJS+JQX7bMwSj2R7yVYZf1Zfq/aoH2xF7v8y4G?=
 =?us-ascii?Q?bm5U54TeqJntSQBFDLDWi6Sbtue6QM5tTvq/2XuXAZgWlAovzCkwZ+8LdtPO?=
 =?us-ascii?Q?ptAhUmcXm3YSs8MbxcRrtAmnKv+TIDSmq9HKcAPYF6bLa2sxOmM604MPBNq3?=
 =?us-ascii?Q?fbmdnem4Ovb0TxNuJhZdBykYueXNVg8oC2geyip6s/cOxMpjSZXOy6f564Zi?=
 =?us-ascii?Q?ANSQCZEc9y18KhI35BLF6K4s3nrtLUdzI+Sa51sFIsqqk//QiQCtJX3Ghgh+?=
 =?us-ascii?Q?57YLkJ/xhPWH9dfABVcL/ItZvBUPoWH8V64S+jlpdq0dpwQo1lCnuaLovpXx?=
 =?us-ascii?Q?zcCOAqhNgSNSMRTpc2ZKfPXH9/6O3VT6r2bRa6hEz3SyWfyhFotVFLaATf71?=
 =?us-ascii?Q?29pYKrPeyhUnHcH0eyIGMO2AnoulECqrIdThklWISgBH9TNrGX97uuoCE39Y?=
 =?us-ascii?Q?BdGlnaeh4l6u6KThdaql5itKxhcroKURU2uRJDfYx23bc+4vKYnd1QDVtMYH?=
 =?us-ascii?Q?YNggKWV5t/WY+K5sOnR3ZkFxzG0JcDiOeGtPKLojQDf70vXaySGU+wLDTC/X?=
 =?us-ascii?Q?AXrin+olQqxO70DOgvlLfc7VFEuDevDLeLNZjCcRczQF/tKUzbqwfiiZovs/?=
 =?us-ascii?Q?7COMtNQ4kL18BQOV87o2ZDhGhyhpsGDYcn4wVVKiqLGsXOB82KDvPjhAeBcY?=
 =?us-ascii?Q?vSQKAgKsNsLBYT7TBahth8H3Ig/U3zCPxdWDwIViYs/ZopGbDF+rdJgal6VJ?=
 =?us-ascii?Q?KTRipH9TpKuML5cS+qDSwAP7w071/ygUxlSJgxu7GxzwAP0WaijYvoH/S0As?=
 =?us-ascii?Q?NosyqNCS8yJoOZxHOB+vMRY09qhvHGH1BWWyqyTBh8Yn1QR7Gqy1CAMU8JoF?=
 =?us-ascii?Q?K+aQJ5DiVjeknl1ZKcpbe5y80HP7MVZ95EhMy+CNB4oZPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFqlWZRAvPQ2kKeJh3f2iIpXtN2db0LWHCLyIoVOlHckh29syfJHujk7L6uz?=
 =?us-ascii?Q?UFNij37fAggyA3/48SXKSJjclLkoNrz0RlaCP70s5XEZE3AT/kfPMReOif+P?=
 =?us-ascii?Q?vZH03eXMGq2MloAUdub+X1+3luDqboTmnQgmP1+Cg2tMMqe+9NWry/Lk+qD0?=
 =?us-ascii?Q?0+7Izi7/MqpH4JCBeFZyDkLLqi9Xsqm0lG0WsGDp6MryUmSfnxZ1LuJV/k71?=
 =?us-ascii?Q?pOlmYn9jR7j/ZcsBQGx0Q18cF4vMUQvZA6GP/Au2X7ha7TxO58xR4zgvkcoF?=
 =?us-ascii?Q?HXkd807EGjGst5Ra3/NNLdtyMOmsunJRB871CYpW86a0UwY12ueZRom9xbjY?=
 =?us-ascii?Q?1TcIBWJUQlFM6JoQqwU3FHetDxd9rVlYKsw2Xqm/wB08BZKInQss1sYQJaUh?=
 =?us-ascii?Q?0VlXCwCISE9o411EWM9CcYM7HiDkq6F8e+TV/EFdN8M3ccKODX9gyvWvnij2?=
 =?us-ascii?Q?t1G1tC1gSt/XS3jw+yPEB+2nOvbhpNYHUJVEETsAQS+qAU5lGP8YTqq/FeIg?=
 =?us-ascii?Q?fzGv2EurkG/ZUbC5McYfFEpq030bYpzq4huDLrBKUSy5zYInHkE4ijNfmFyx?=
 =?us-ascii?Q?k1xGy5bKVcqd0BiH5/++jCo/gHVHW2eqUH3FE/trAj3EHt/8/mZSmq8WXXBx?=
 =?us-ascii?Q?7IK92vnCYoXihNHTfwdTuHkIX+bUnTZdCit5SaN+XvmLHbyLHtXHgGdAAusy?=
 =?us-ascii?Q?a9SBquqFu06C/gN5ITG5npro8xtUEYFDTxtOJ0QL4oQrdmT4dB17L8rYMFSC?=
 =?us-ascii?Q?NSq2Lhu/rnstGNozH942Dks+7rRvqvocXEpCSMhP4u6+NfNth3+YQ4Eto7ld?=
 =?us-ascii?Q?mOkrkGCfBeI7Dyva2s4G+7HFv2eFBtcncM4L19HVYBRXQgxJVUKD8AKct0NK?=
 =?us-ascii?Q?A4dhHhyhrbrMEDMFl+lzZG9TYtwj+0syd0hHoH+u8GUagZESPSKEzZiOVjsR?=
 =?us-ascii?Q?u9T8zudS4GVUe87d00MAwOQTFYDUKTekN7JEMLYUaSg5lDDJtexc+GJXqMQn?=
 =?us-ascii?Q?XOFdWzC1f8W5ZocEyBO0TCJ9/1PyngB2bAdamW1S/iaOxBWix8zJOi62JBs6?=
 =?us-ascii?Q?70WI+cWneI/FgXRPGrP3v9VPHtfeWHTsfl9GxlrMnlpYwARiUJs/dnCwp4tp?=
 =?us-ascii?Q?3GOTKqfr3ohQy+ADerY+LRgrctA+qiA60uaxzLdmHWwm5miZneQNxdVQ1rpH?=
 =?us-ascii?Q?o3541f8p34LOkhEIp4dX9P7G3ZI7XmsjIUalCcDrPGCWYHKA7RqNpwggVUHG?=
 =?us-ascii?Q?MFnD/m5yUkbu+K89KCbMCy//JuPpX/FQt+48oPu6lKtL7KR2Rkb0jd/vFuqN?=
 =?us-ascii?Q?v/59EwPeaZgyWlaCYnzuqLlpCf4uLPCklQlAe2mmscWROiFTMnd8+O8+fzQL?=
 =?us-ascii?Q?C14viL90m2FOgVGptTVx9h2tOrFjyW+ibwRH4S8u7Q2+pp4un0UXfuxUUo10?=
 =?us-ascii?Q?R+6pQUpDJ88d5Xb33t++G07eWh/FXdX7S/sjRDaUYiEEnCumWkZ3r61I4IYx?=
 =?us-ascii?Q?TaiYu2zdWixe4xYe2pEQjfWjMmzQ1mp1IfnDXHCaT1WnctL51OwnNSAV0CIV?=
 =?us-ascii?Q?05FPSj/TXiH9gUVsGr2vVlrHbbX5D52XuY/FkFH/dUB7Rd5LJjVbFm4IgKYu?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3485287d-632c-4daf-c581-08dccdf2e54a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 21:37:09.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGLC2gnKfM7zLAQnTgK8conojeLOdZIp7ceoUgScbeIeiI0Jy4/KdOqRF+1wRQk117tFr+GpvpSUc1awbTQ8l2pWBhvJlLM1LsPj/8/K4uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> > Huang, Ying wrote:
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> [..]
> 
> > > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > > > message.
> > > 
> > > Emm... It appears that it's a common practice to include "Cc" in the
> > > commit log.
> > 
> > Yes, just ignore this feedback, it goes against common practice. Cc list
> > as is looks sane to me.
> 
> It seems nobody can give technical arguments why it's better than just keeping
> them outside of the commit message. Mantra "common practice" nowadays is
> questionable.

Yes, question asked and answered. Not to your satisfaction, but the
people that have engaged to date have been cold to the idea.
Historically, reaching into other kernel developers workflows to
instantiate a new preference is a high risk low reward endeavor, please
moderate your advocacy accordingly.
