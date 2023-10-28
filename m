Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A17F5
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6TJm/NM"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F27711B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 21:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698467377; x=1730003377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AUtFZCzdsaGxctlnkFgROx3NLXd5jb2OSKp1dtyZoiw=;
  b=K6TJm/NMoVvxRph9cxXHDhLgIwfL+7u71CNpJiCqYhgFyDBBmeNUC+b/
   JllaGAOolei0lp2xNIzrAiZgO/ZZxHDABqfKIhr6EPatHfTgMzh8c8ryP
   fhZwDcPjK5qO/ze89Hk1zehULMUGO6Aw8MiSX6F9/ZUYn3RUQuxJYNGS/
   qTH/F4ZxONnafuC8l015vQ3oBMxvdsG+T4wD1vLzTi1406uaGz3AeSLjV
   oLz0SXwxHQb5gZmJqj8OVPvra/cxm2OHWQB++frQ9XTCVWfZvEnhjtWAI
   4O1FpBjojQ9Ik80dW3pP6Q+gss6uEQ1r8CjWlCRQFYyLWM334Gyv3I8RM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="452125009"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="452125009"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 21:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="1044418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 21:29:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:29:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:29:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 21:29:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 21:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuIbLS8WbERnPJMuDDo7FIg/EiB5bQkG+3EiRXnOJ6YHft5ExclpBMHr3rb5y9lOJIDQI3GUhQzB/vLxaNAO6JXJd3XJqbY9pg9pUxE65jIdEmKNI4sRESBRkCmF5gV3fsYBQa7qExjy3jqfnfb4vkvpTlVoXTnSmQgM9SOing1rbyx0G53l9QZgWAWNsqyT+5ErYPDDpsPa9T5zhAwTdao/w8GLNFhvSR7qEnw8C6H5xQuyiK+krMdiF/nv0DrWzdNnB14g3nBeuybFjGhrXVXvx9lctOh/+avR1mbKGvjfC8fJWlc+9ybEy/dwPT/AwNWlOSniPFp3icybsDh17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NzIBrD4ecGule/8UI9VSrBd38SUFYzOz3BkcfjYD6o=;
 b=J8niQzp5QciZNNOXZlcL0Mx+ILQ+HIaIpUtec68+yINBLi7iHg799BoUlhnNTeGQL+5RHeOlPHBQOSZZuDdJk/IM8rW50OQ5TNYce/ZTGnqcfO1Llw8pkfrYBHF/4nBsCmPH6y/z0H+vnKb90RtcUNkId4b04yoB7bNz8v9eU7dYIMWwacVBe4vseYu+sAvl29XDfczfv6wEnPxu9LmcFc8r7ju9wtSR+s3MaBpxIwP5jSTqEMlGgZ+aYhqVTCFavIMCFpwqD1OO0kC2Ceoy2V2TYON/0gvb+gtZmYUcc4VJ4f1Tak00lK1ZBRR2qpxQaIzfXpSv5tNTIbRQT8cEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sat, 28 Oct
 2023 04:29:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 04:29:33 +0000
Date: Fri, 27 Oct 2023 21:29:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v11 22/22] cxl: Check qos_class validity on memdev probe
Message-ID: <653c8e2a2dd08_244c8f2941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <169713694184.2205276.9863653630713216825.stgit@djiang5-mobl3>
 <20231016120425.0000542a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016120425.0000542a@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8750f5-bd7f-4d56-b7d6-08dbd76e7bd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi0ALon9Qvor4bfjFevYAW4JzjOAyyg9lyYhZAuHUo8z2VV8SquHRYnatzMJVkklQ21sLTyOmcSzvk8mQtWTbMM2YnLZU7S1YAzJEiTljKBQd3E3aSjjAu/gDMllxQG3Y3v4crIImUSw7mO4xl8kgB8eg74Q7GM/+rAeZqsS0GlpV9V55GqCHYuPuO9s1ZOnAtXI1cDNMTucsuZpIBJr3Yy2tNgQzomI9N0Bv/7N0J/TQ+qSu8Yv+NzTTGUpAtfCpBb0deKv6L1IDpxauh92oLM3VTFtSjwlpUzYbxub4VC9QiDACUp965VJgrlk7Jpjd1wwYGpofJ0Fclk9/qbRRfHneS/pQTXWwt/BJhDwReqWPVzOll5HuRZWockQ5Zpk8zf+n8TOQRpzysjt5rFgH1jrsiMaraLzo2pKVFamPxLCACOSwHcOzJGHX4yaVWPiZ27KYGRWG+cVY+hSRKDzeB7nNAv6cZ7NC1Bk3neJmaRh93FB31KLXoxIYH3Mwfb5u0nZRqrx6YwvAZpxXWLq7WohoPFfYIiWR25/BJ249hM1ccfNfX9VuXgjsSS5luoT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38100700002)(83380400001)(4744005)(4326008)(2906002)(8936002)(8676002)(6486002)(41300700001)(82960400001)(5660300002)(9686003)(6506007)(316002)(6512007)(6636002)(110136005)(26005)(478600001)(86362001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YKh155S+goIYYSDWkU7bwjzSYxonJ4lR0afyoCR/5kosTuN5lPybCPuB0nm?=
 =?us-ascii?Q?VPUmH8Ii37UXoHygrpUcOS9OkLVf48tyG7BsJhKzP0qsrnQGhf7IgjI5fKNk?=
 =?us-ascii?Q?SkMIxIAZgFfyIQfcr4FkdZDbf2UvEEOPMHpPfUEXL0txMo08vf+FMof5DU6Q?=
 =?us-ascii?Q?qTo8MN8AIPib73v8ZsfADIZdPqcDVtxeef6XhZTqDaL967pSTaWsriKHZPix?=
 =?us-ascii?Q?jY+vN8pKgxVzge2m+XYNkaKyfcvK2KV1vnzt6BThuxyjHqCboqBGGBakr3GB?=
 =?us-ascii?Q?w3EqjHw5/dgYa8Vk9xQQr9Tlabu6z1gDUYAGNyWB4fZ7gR6IuJUisqHjol0S?=
 =?us-ascii?Q?9W1Bkioyg1d3h6hON4+GBXfQ2/cmL4Tr0SmiiifDqISxHn0SC/NLuHHL9QQk?=
 =?us-ascii?Q?3aO2YLU7m5ZJBHTIdXRBQQqrfeJcQ2NXT8e3L3kkWQH7+3b1MEnCEiASphJt?=
 =?us-ascii?Q?I1qmjL7QL8YnMjbtIYjRUQGuWaGAyTmHlLU4WrVQMBtzxP+AkE2evfcReCZH?=
 =?us-ascii?Q?op9iKuyW8HcLlyz9Q35dSfkTbSDJwWrr619r5Jtr8bKdS77lYqwpwOV03eTs?=
 =?us-ascii?Q?iqr4KP242y5kOo6W9/X2UJ192T3xsqasipTUp1H6ui2Rg+ix5StdwTXPezJO?=
 =?us-ascii?Q?/3xwoTgDgAQHkqLSN7PewU2nDQ7Mlsn/UvjWRl6rwPnQGzJJg1zXMkBCIQ9O?=
 =?us-ascii?Q?Iqs5cqwUUoqhT9vJozRJF1hd6J2fQpR/xnDfaTQKX8bndj3XTJ4Yki+lEKxV?=
 =?us-ascii?Q?T8GhcIp0w73VfRfyO2w0h2CP1LhxEVN0q1LIUOHw0wD1bmsx9sxkcsrHXUrJ?=
 =?us-ascii?Q?IbJ15dnYf64mlmFJswntZqzJjiYe1d/FsLbSQbRF3xpHKScLPRBz7JyuRUxB?=
 =?us-ascii?Q?nN2FcSL7p0q8Ur6ONAxAaFfqcoRloL1Bgv5HiffEnJB/KdCAXCXxT6+kLZ0/?=
 =?us-ascii?Q?sW1hXbnLp8ybDvek9PpespOFkaQwNhIio4gbiYnrfdkkYD0ocYV6Gr948ta/?=
 =?us-ascii?Q?VOwAbt4WD4YSo46dgPjc8g8rrjcy3oYdGGcRelrqZ3WDZDeNeaio81x8Eptq?=
 =?us-ascii?Q?M2gHIQZZoyQvbq8tKypNm62/1BfejgP3t4ceT09GiV76cX7vAXx6DVNuTHcx?=
 =?us-ascii?Q?7tC5jy+BxJx/Otf/YSK5zOTV0O+MGJyhejlUFret9+OpmuJwIORcnR1b4yv0?=
 =?us-ascii?Q?fNIQYY+Vipul9ij7hoBHGfoyipo5SDvqltBJg/w7QxSBmIZpWNTqW6PN6H+L?=
 =?us-ascii?Q?bkZ1KkgboG0W0C6Sxo1che4IjkUFO1i8N5ESSy5yK7ATdkkQEDG5Pra5aTwK?=
 =?us-ascii?Q?xINt8tEVPfDaNrNZY+RemO8kJ1jeC0vgwnEGqCFMxzU5AlAY1x53Rfcp+l/P?=
 =?us-ascii?Q?HlXEGVyK2d04Muk7q5NsSji3gi3Mvbu7e6HwEZIpoUurxFbbB3IUkBzoHyJ/?=
 =?us-ascii?Q?2akOGWxn+Fh16LRYzn9nLD64B8hTBfIouk3ECS0IqGhUzRzjfaxhi5WPP/+r?=
 =?us-ascii?Q?AeAJvPv5plMGS55Tg8g24eNKptqujGCY7EwGQmo+Ow7tmsXteDWCZuVUFio+?=
 =?us-ascii?Q?9ScIjldgJTbKKbLt4layrwpBB+LUJbjai+xLxmqQ2XivR+7UdfkgpyK6S+W0?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8750f5-bd7f-4d56-b7d6-08dbd76e7bd6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 04:29:32.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1rQs4LxMDyDKitMEA5M9L7sr0arUpmEkeob5I0YIgyWKG16gmG1D87g3fUQyp4QA5NLrQnCo2M+TxTE2HcmSv4YBblNxZsEuwqoQeAO8mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 12 Oct 2023 11:55:41 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Add a check to make sure the qos_class for the device will match one of
> > the root decoders qos_class. If no match is found, then the qos_class for
> > the device is set to invalid. Also add a check to ensure that the device's
> > host bridge matches to one of the root decoder's downstream targets.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> So, if I read this right, QTG is required for probe to succeed.
> Perhaps that's a little too heavy handed on something we haven't supported at
> all until now?

Agree, that this is too strict. I'll fold in an update to swallow these
errors.

The other thing I wanted to see in this patch was falling back to the
next valid QoS class if the first one returned by the _DSM did not
match. That can be a follow-on change.
