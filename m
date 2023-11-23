Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8CQ8BSx"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B902D110
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 17:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700701968; x=1732237968;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VMgr9yT/ikYJX1JBe36cvGNvN9+CAFyBltaEP8pRh10=;
  b=Z8CQ8BSxICvkZIGPBTQGpeqeBCXiLHlrN3LWUjy8IsDMRaLL5N5GlFuo
   VWlfbUMldsDVQ962EHTtIYfQmXnaTwFlplN0zk/SkOZEpwKE5UvhvQysp
   PaA8GeORS6MShByONFIqqfmRIg5KJeFsc0DCDzzhsfCbiMebw7mIAIz8b
   r7j92g/fPrJuVNDBQ5oP2j3qDkWsJ1ktfhD916nP2C0yUszdCK7W31By7
   KGXOk/7/75HtnUeD1SyaqYUcwLFJL99AyNiT0EqJfPJsMla/qA2IZfkur
   2UhPZimCgmYGG4QoEZpyo5Bw3vH+VjcmyDFZm35YqBKs4G2BhopfB4sau
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478373519"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="478373519"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:12:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014457549"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="1014457549"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 17:12:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:12:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 17:12:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 17:12:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUAbDh48ajERXOmpjlxOF1aIe8J0NXXoI2FBDb2mWAnV3sZq8NVvZQ0UqFwA7Ka2KHL6ZRgLRkgxxNpa8NXqxQVX74NXbwhXQRVCada9MpV0OlKI2/bMQoOy1E0dzS/oDpnRy9hNXwkfFaX8WCMlP0MSE0OauUrMexXIb4EMHpRCmm7EI5Ht7E31iZgdiw5gqFgL4bGL7P338M+j8GuV8kUwrBaiIj7OD2CWYkhxM8WONvsyhBb1I+by80HhJRrOz3mOPt20W3XQKkLVsffMHJfI0VPOW0h9Pas8804aOHs9v6pu6Ln29X9Cr9pHjFHVIvutTUIZV/OXq/9/Vu/6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/ydQFwLv0k9JnRx/Gdt2nc4qLhUHLjkGiCMsclc7dk=;
 b=RCbSbxulJeBrwKOPhqcqPnNOvV39JM+kb9UIiwwMs/mezS9bsl7DozK01UySg8GNpDw0VJLF4HsaGRkLO25hKYjq4XyH9t9TgJE4/HHTOh1fszdB+fE85g5PnHRNOvgenc0n2QGNb3F5fZAPg0KV4d0sO+uEgonHSUl2ahSFZsbwUbA2qmTqKg7vIfnTMtjIhe1zqlTFzignMJ+87LSJv91SDe7rNiFFGjwDFDi1P8xD9uVdhR4qkF8DQEhn1V4WWzcW5Tf1AS/EY9N1WMqYZvHUOHxS3ZY/qX+73oS1qdEeWwjaNeagL68cpdjeQ7QfhOkM8Bcd8uOaiJKzN5A3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Thu, 23 Nov
 2023 01:12:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 01:12:30 +0000
Date: Wed, 22 Nov 2023 17:12:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Convert pioson ops rwsem usages to scope based
 resource management
Message-ID: <655ea6fb1b180_b2e82942@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
 <169998626910.1958731.10157698499207717733.stgit@djiang5-mobl3>
 <ZVVVH8ITotdk1nyN@aschofie-mobl2>
 <c35ce419-4881-4cb9-999e-d3034ecad8ab@intel.com>
 <ZVV7nYEFHVuXskm2@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVV7nYEFHVuXskm2@aschofie-mobl2>
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: e58dc988-1723-4b9d-5e7c-08dbebc1439a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MXtw00N7CZ8FBse1UfR6fPCXNtPeNsA33oNJHOMAhtwR5xzFKegxUN2nBwJKw30tynEpBUXmyxp7iPNbu8n0ycsaj7rYrTKi1nXuJpeyk4OMF8IloQdIR7LR+Bx+YStVAfvW0csbANdAc/0uB6j5tyge0VRAXXp2yDGI7FKc5H18MwAgWiu1s8FguuX0FB9Pbd0pSbPYsp/BQ7k3iFaCrrwkfb08jCLashc2ePUQHo1HRQXbEA/7/A5mfI9IA89c2oBTBFp0lGX50M3r6UkEwPfPgzezg9fO/LGxn+aHQpcJfVhSF/1qCt7gqjgMEiU3L+SLA/i69eBLw65sODqiJeuzpzzbAb6hFJCvznCoDd1XrlxC58a9XgXh5i3NivoRC79AlmD0WJfEKdQKOrKAZO8pWlqRWngZ/ENp3oh4AuBHhqgfdrh7OhCUr6mkskGB9NpWOth4/QjSP9kJB0XCiPDvnMLTDCBnhd3EEpCjcTynrrMDjG8FB22JDvxnOQrOWDScNllpRYWwtt3Hz24KJr3oN6e3hzDS4ASsYtZ+bu5F72nc9lz0YVua63jQofO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(6506007)(107886003)(6666004)(6512007)(26005)(9686003)(83380400001)(316002)(6636002)(6486002)(82960400001)(66476007)(478600001)(66556008)(110136005)(66946007)(5660300002)(8936002)(4326008)(86362001)(38100700002)(8676002)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ICv7m+CoPju/ZgPC3tukMKHLto7uXxSk07JNfktub9jWqj/MHqFs/qEmAovh?=
 =?us-ascii?Q?IWVJx8/14Okty2DiReykZsN8MZPhQ8CheIUd9LwFUwERsVxVnizOtCgwumT/?=
 =?us-ascii?Q?muMP8ZrvS9h+Qyek/9nnUG6O+73mk+hrpwYJx8B7/I7TsRgW/R+AdXuS3cH1?=
 =?us-ascii?Q?z5y7peFZU5rt3Mm2KzLs/+bKJf35ONwzSI8pOGpZVpadfb0sAD0xBKXodCq7?=
 =?us-ascii?Q?X8Vl8bp09p4bb/h7Uf3nayyxHFsfR9dX0EMVutbqc1me6NFS1YYIM3w8M446?=
 =?us-ascii?Q?QnJMXjbuBwa5vibJw4ZM2QK3WiVAAjV4Wd4qHHDBlooi+m85I2tsEbiLtwmY?=
 =?us-ascii?Q?A+dfSthugyH8EqMUqG1N1AbJRO+6QBs9noO6S9/q9Olem3h3lWf+iMC/CFu1?=
 =?us-ascii?Q?7xs7r8zZobz2dRouQUjeoK4d845589FUfU6D3oVLHXybMN2eL2JNjRw/bILL?=
 =?us-ascii?Q?dWVuEhlSz4OnGPIGkOy2OJtcZgdxAFz4C7bWgbvqINOBOQbnOuuyU/vZQ17W?=
 =?us-ascii?Q?f12X1pbf8y1VNoBDbK2ww8FldDHv4J+wwHxV3DufWm8GyrPoND7UX07sfQqJ?=
 =?us-ascii?Q?Y/d4iG1/1e98JNoZQ7y0NNo2dmuZuXEoosyaprnQIuMSuHGBauQA7nKFAbPj?=
 =?us-ascii?Q?rx/mPKNQ8wFNXaszdEcg5E4OcYPuSjxAi3REx+2qB86/0luToTUuNuZ/6cfg?=
 =?us-ascii?Q?6rfp/ZU3oiik688XDns2Eruu6RjiJpPJtL8GPBOAZt0bjY36haA1U5/T4ChR?=
 =?us-ascii?Q?ewEuUK+l4MaP8GgjqxM6fbdZ7LiVECY2QNOK/T+3FYep1VAgr4r/65Wyu18v?=
 =?us-ascii?Q?Q4m2vT17dMXVsHl6ausVSY8QnXDjRBK73OwtzPRN0NWAcBk97K7nj9nMDv7k?=
 =?us-ascii?Q?49vDX6MaZmTVXxMNGV8cM9UXVeTWYzmhjxEanrOU8nrdhT2Tjo7HI2kB2uI3?=
 =?us-ascii?Q?Xj1X2UytKOK4qX5d7xSXmZl8VzhgG86983zSdlfsNLWKp46zLNCx+dr/UdEa?=
 =?us-ascii?Q?ufSQFuWd2uFrwgP1w1nQcRDJDPjgeRdPBE2LYPvsaIPYhp7AxnGAVrze8amt?=
 =?us-ascii?Q?N5T560aqQxo9O9ewKhmbDbLIzgpNNPhM8DuuE5YXPRQfKWLHRLXQrDOBq9RK?=
 =?us-ascii?Q?Tx1oP2k0L3ddEBJSJqS7tmYcedN7BxWmdy9wCvPUllmSWYx1WV7R2At/Fsh3?=
 =?us-ascii?Q?k450iA/ZW5zzwUWT0NWH7nIP9s4VhENV2BZDnzO+FTWQDHKGC545OqahrA4B?=
 =?us-ascii?Q?RAIXvXTosHAYaxapcCob4/wwUekdypr0LHGUw1mSIAEMzURhU4QOJleNClL2?=
 =?us-ascii?Q?NyBLTf5M/LFDSdhxtO4C5mu32TQMGnEb/xibB7o9aqSk7dLF8l5/uSSnyPqS?=
 =?us-ascii?Q?swxUter/+YqVhvyDqJFDzXd3nrgngB0540H9QHWg7/WTivay//QjTOIhxNHb?=
 =?us-ascii?Q?2g9k67SrYIIE+fYxiijHtOed1qyev/2zj6Nb0itGsO57TbZBResF4Vg+1hvV?=
 =?us-ascii?Q?JDzda/lZZ+z7ZUO9TEaee0oZTaHiQquNa6HcbWKpusifwI/+zhZcJkWRtQHs?=
 =?us-ascii?Q?R6WrLJOLiv3SRgbocQ/LJcxy+/41fWt0pBnlGV6rob1BCFemzQvAB7HrjXLi?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e58dc988-1723-4b9d-5e7c-08dbebc1439a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 01:12:30.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/Etr6/78GdVhc6N9KRCCKZbnyKC0Be0YAGI4i0SvS5u4/IoSpn5hpkFr57ADzLiY5Ekgc2O2QqqxegAMpYWiduXgRJ/MtNldpbHLF1CFmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Nov 15, 2023 at 04:55:11PM -0700, Dave Jiang wrote:
> > 
> > 
> > On 11/15/23 16:32, Alison Schofield wrote:
> > > On Tue, Nov 14, 2023 at 11:25:20AM -0700, Dave Jiang wrote:
> > >> Cleanup the rwsem usages in the poison ops to reduce complexity and reduce
> > >> code lines.
> > >>
> > >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > >> ---
> > >>
> > >> Hi Alison, follow on patch to yours. Can't be backported, but nice clean
> > >> up going forward.
> > > 
> > > Tell me more about your backport worry.  Are we expected to avoid using
> > > the new guard any place where there is a backport possibility?  
> > 
> > Given that there's none of the cleanup.h support in stable kernels, I don't see how we can backport the guard() code automatically. Thus your original fix with a fixes tag plus a new cleanup patch follow on w/o backport issues seems necessary. Otherwise a separate backport patch would be needed no?
> 
> Sure, it would be needed. I guess I'm looking for why this backport
> issue is so special. (not being sarcastic). Is there specific guidance
> not to use the cleanup stuff if we think a patch might be backported?
> I don't usually consider backportability when adding a Fixes tag to a
> Patch. Have 'backport folks' asked us not to use it?
> 
> I'm imagining the slippery slope of not fixing something the best way
> because we are worried that backport folks can't figure out how to
> merge it.

Upstream should be fixing things "the best way" in the current kernel.
If the best way requires some work when backporting, so be it.

The general rule for making backports easier is for when a fix
identifies additional cleanups. In that scenario the fix should be made
first and then the cleanups layered on top.

The cleanup.h helpers are an interesting case because they allow adding
new locking calls and defining the scope of the lock at the same time. I
submit that cleanup.h helpers are as easy / difficult to backport as
open-coded lock / unlock calls.
