Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FB370
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeuWObwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704759995; x=1736295995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZDk9B7zpeh9qJAdIZg+XNlGrgC9Z4WphFrlkoALXzvk=;
  b=jeuWObwaQL56ATKYdSmow51WafQH7h9cEbpBntj9ivtW19g3+mTzsSAd
   0tcS9pQ9hUpd2YbXIg919wy8ZzZ7Eby7WXkoCjMscPbmXrPLL1s5nlV9V
   SdVnH+mY0s5lNUcPKQpYa3LGPHBoZeiD6sIni781XRuJ4sSO6JWtGpYPy
   mT+256kGMXIu9Mn2phVAMRr8hd2nYwTDg/utmXC8XYcx9VcLfXASxuiwT
   4g9WMIjjLbwfwrn3OC9oZBgmkX3824GX5l+uCcB1gEDNe4cPmv851+ZX+
   qDBLWMIyV/KWLTrU51eT8nm2qhRueD9Kv1BF+pJIRX3f3UlK6RD5O9/Vm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4799860"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4799860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 16:26:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1112886643"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="1112886643"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 16:26:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 16:26:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 16:26:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 16:26:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 16:26:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhWQI99EB3YN2iNjUiR2lOVr+Nq4ySE05hltKJ0UX0nltCMyyzAiHttsvCIm4EylVcQmyY5BGpHkZQPFvi1ED0RBZVt0eV2SGAgE9DwZGnVdOTxN51gdHAd0ztDxyFyL689XDZe15AbtyTfdcs1oJnbz5UXd87EkqsDPD1x75sVS7G/k7Anx2QOIQZP2w31PB69ZOq34EfKZSSIpGGve/uHSxr15B48A/RbAgWtY2C8eRVMlv3DK6ofMrBqd1MgaL5SsPQTza2gawo/LBe0ypUnRGf3ohxnNK0DcAyXNyEWg5MHrXQYAQ5fHiGBDFtfi5PUYXE/MplazHv6J40iKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10fMFZO430eqnrO64oSYmXJFrs6I0mXVffGpBWVBOj4=;
 b=mj7H1ou+RvQ0iFHtrAK2ItqgY+gVSJDT+pynSE5KFPE6fG8DmpyqMiLuZ+s+z6CSXADej+mW90ZLlrsZuQ0tJQyiRFCzjcigWSdDpOJuxIxA1Ltg5ySejd5wDG9lgAcsYPx4PkkgJGVuQBZNnt+EH4vfifVMhghuFYQf3FJadD9a3PbRdR9oH79gz2wUDOUm/8CSotVC0yRQN8cGsu4nmLIp9icpP95oZSq0V273DookWzPn+K7kMXPj4Cd2uSwN/tZsBoN2GRTBVTsfv+c826zoyr/65m58igioyxWoQ+f52wClZZPBlLLZh+quS/RcePeiw9bOjDyYcLPORR3Fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 00:26:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 00:26:28 +0000
Date: Mon, 8 Jan 2024 16:26:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang, Ying"
	<ying.huang@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <659c92b13610e_127da229484@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240108121538.00001369@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108121538.00001369@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 518b447a-1b64-4e19-7c60-08dc10a99ec7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4Q/0cPJ63ohRHJ7hY6FOonXse46ekl1TFK80yCwIPpbVmo86GRh3sCKpNnkppBK+jKJLqm1aOwyM6wCWHQYhUCDmmA+T1hglClX/S180PjEjcmcCBShu2YvBG/3bdDp8WB5UcGlYlkxx7xu5jzpbQG1pzNr5RNKjIM/8KuZgTZU3xZlBVFt/AJ3+/VTDS1sZhGtitqdoxIMj0IMU4xW4Pg7FCY3XPMKL0JG6d9P0Pvl2hRWcbgrNPlJ8W+YBr/v8OQMrKhtGNC1DiXUokFrfGYJ7WVsVR3WPMNTuOnwCfJ160BPOEp6Dl+38E9mZmTJrUDmrkn87mIY590206XHCV9NTP0Ihp84Kuhrjn5pfI39wolpRSUwTzCyuYetgtmv1Dg+i/U4ZiHKYP7/YpWLTmp+QekNRqoTWAwBMYckj0M8jtZos0v3a7hp1RQE39RCli4Xhz1aH1FNBedfapI4dEhb5pWNaZ06c4dKz2eBsQ/LIjGHdhXrcx3DQMuVdS2inxAQv+TcvSpoTBIbNz+CxmHuZQgAoWyxaUMvN9tep5vyUVV8g++wVsPC0Jf+jyf/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(9686003)(6486002)(6506007)(478600001)(6512007)(6666004)(38100700002)(86362001)(82960400001)(2906002)(5660300002)(41300700001)(6636002)(83380400001)(66476007)(66946007)(316002)(110136005)(8676002)(54906003)(66556008)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+EaLVhUnVzzdhFiN38fJ83zW0zxOG3d96DgXsX+4bKTrtCptGwZ+9zVlsR8b?=
 =?us-ascii?Q?QIPTwQWORax7QiXH40bAQdxUqBkB5Q5Wxz6UpJBoZ6zid0IKDaY5tJuvJjK5?=
 =?us-ascii?Q?UX0c9Whm1tGDJop+6HlRQJ2C4QHPxcAfvvwapuJcMxvEXziROMbnnGcBz11a?=
 =?us-ascii?Q?epR+DzeNpQlzOEYVsAtISTAVTRRX7do4uH0duCR79uG/MGIBqLRhhyma2Ykg?=
 =?us-ascii?Q?n8yZlW7BX5VpzRgdLb222/beWQphHSVlc3RIqd5OISHxq1sIqyANMyTHXnxZ?=
 =?us-ascii?Q?+PYhJMnbFGN7n93QWuCPG5zi7HB9AbhMDFsLxZzDYfq2P5M3jmA4cRVlejxf?=
 =?us-ascii?Q?hcKgCtLJfelgWlq2KIA23DhkvpMxKl475iOORKZ+e/exyNSJ3OGPaqZWxU5L?=
 =?us-ascii?Q?dhqDLBWKdNzsiZIDKU7zSo4DP7fIkTdK2n7QY+rWL2PTPFbjChmAeMpIh9RW?=
 =?us-ascii?Q?5LOg+w22zSjhoe8MfTjglFuLGBhfksZlnOC98mzm0fUjX+w7stz9XX4zmRKw?=
 =?us-ascii?Q?5AjRqQFYcJevyU31yS1Zu0ZHzOePZyRo3ZjzXFYHv+6nGEDqNvShyw6pWuNC?=
 =?us-ascii?Q?O5dSJTPuljv0yJmP4E6dXtFs9NyW8IGtca5ZhDf+g+2h83frzt/DqYk1V1vx?=
 =?us-ascii?Q?qcYdpbPnk+Hef5TOWWJxE38Xzx6b+DyrglnbbL4nbR54GUt8yZd1MSviqM75?=
 =?us-ascii?Q?3Vovhv7YoYGa22lY78gUZpYcPuUatTjZuJGyaJ5HhRBhqgiFzVcPNU9Eyfko?=
 =?us-ascii?Q?W1J+kgStYEzEC/p/LGSFWOEA9V8cUAb9EbQ339nFgCxdsKOG/qrMAvnw7H1s?=
 =?us-ascii?Q?JmPzJyMissfCZTGk+XBUXHbTu9dvE4GIgdFiYXJNt9k4eCYUmlohDp3li7+J?=
 =?us-ascii?Q?H3GOjLXsQe9xYtguI4aa1JiU+UR8kRGJWhcw65mE6zKiw+qexggQEvtM2PYx?=
 =?us-ascii?Q?AvM6aFc6bDvrE4GlcZq2ubGQxd5S2+I7FNrLv/VS7nly2DkyQgE5xQ4iHo8Z?=
 =?us-ascii?Q?Hsyc57tORpZxCjBy2mkdJunysc0NBB+xfmkr9LT1nDSRBTngY1aRqZ6RlMto?=
 =?us-ascii?Q?kYnsLtZJGua+GcoqWysifqNdhUHtyPKtYTjmW5cGMftdRmaUfdriP5T+CVsP?=
 =?us-ascii?Q?Exjqe0bJJGdoPyd0OgvS1n7uaRfRBxL5xhfNuQeN/9QHt32KtScnomwH2uP8?=
 =?us-ascii?Q?CPUvBgO+I6kF8GMFQnKzCb0YGXRlNDFS87ZkcDBEGJ6uRsiiyyqnVhTQYtmK?=
 =?us-ascii?Q?7FupeH87vA/mlyBivUN1tBVtUVENW/8RXlnQ5AnKaT/qgoc9H1/vXe8a7qaL?=
 =?us-ascii?Q?4UVO3e6sgBPcBJUsvtXnqmoo9cXkcilQQuSzxSxnK9VheaqcyUTwQdhNBUYP?=
 =?us-ascii?Q?2K5PMjA0tGLubdkxTF1OYXOVfA8G65hDEmKwcGNYf6Vz//G82iwbBI4q4rdx?=
 =?us-ascii?Q?qRiWT9iZCtPOST0aBAHJOVtLXDoHAfJLbkKVfMuymeGQihgkwMkQrHgD68Ez?=
 =?us-ascii?Q?s+JrgWdRQgmZcCSAPisT5kxBqianPfJJtB/Hllyqm7g8gkxw+uUv6UH37X9c?=
 =?us-ascii?Q?8esZ0iEsM1al/5BObu9Vkmignu0j+jkAKNrXPd9esnKqf1etETWLkpvFaDQv?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b447a-1b64-4e19-7c60-08dc10a99ec7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 00:26:28.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2rSGTwekdb9m/QaRvdMN2xvN38cTrhHFmgILPbcWYsxwMG6U6ahLiunALfyfVCMVX6JuMQBGDU1xO83o4zGQMNxVmhemdWPLGcjjkEktqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 08 Jan 2024 14:49:03 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
> 
> > Dave Jiang <dave.jiang@intel.com> writes:
> > 
> > > When the CXL region is formed, the driver would computed the performance
> > > data for the region. However this data is not available at the node data
> > > collection that has been populated by the HMAT during kernel
> > > initialization. Add a memory hotplug notifier to update the performance
> > > data to the node hmem_attrs to expose the newly calculated region
> > > performance data. The CXL region is created under specific CFMWS. The
> > > node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> > > Additional regions may overwrite the initial data, but since this is
> > > for the same proximity domain it's a don't care for now.
> > >
> > > node_set_perf_attrs() symbol is exported to allow update of perf attribs
> > > for a node. The sysfs path of
> > > /sys/devices/system/node/nodeX/access0/initiators/* is created by
> > > ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> > > to the proximity domain of the CXL region.
> 
> As per discussion below.  Why is access1 not also relevant for CXL memory?
> (it's probably more relevant than access0 in many cases!)
> 
> For historical references, I wanted access0 to be the CPU only one, but
> review feedback was that access0 was already defined as 'initiator based'
> so we couldn't just make the 0 indexed one the case most people care about.
> Hence we grew access1 to cover the CPU only case which most software cares
> about.

Oh I had not followed any of that evolution of the original
HMEM_REPORTING code that specific indexes had different initiator
meanings vs just being a performance ordinal.
