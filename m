Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B697F5
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvPpGpkt"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6430311B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698467027; x=1730003027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GNqReQhAqM8CkkjOBKTRsiiAWWf8ecLi1pn/2km3+no=;
  b=gvPpGpkt+8V65Ql1/wVSMZuOuPWpG2yP/u3JjZOZ+x09KyM92ta8OCqP
   C9GGCkI3H9/OoCBPGKsu7OS8paxIMEECn9iXXmQ3IsC/0SWjJ4rWmpmV2
   NZ7lVvwVQycsG+Cm3p8SaAbDODSP5E5HseOh2NDj0jPZUc3jCOu96U9nT
   GZRoyxy2wrp1z9i+eBK1MWQqew+oCY/2m6X6tZbVNbpvZhnJKjl3sEjrD
   tamhzIJwMU59eMiLkOVYS2B+LBBniLSVhjEvese3JFRcX7xk9ktrLpnBU
   Huyqh2SLFjELbu4AO/bpw5jJfhz4TLk5IacRBiOIyCgr6/pQ3Jrmh2B+Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="452124772"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="452124772"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 21:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="753313744"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="753313744"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 21:23:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:23:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:23:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 21:23:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 21:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY9LIYuP2N53BohXar20/aIzsDwW1nFBfpK7MqxM+zVuygjK+G1PJK9T+tRZn2oHmqOGAavyeakWlGqehAjEatrpvnR5TXG00PvgvC2ByDMgmCXeby71/7G8h0KJoVoiSUqVG8KSZMoL0NhmUwPLq3S8hto6pRsmkZD02sVny6yeW9lg9U6/LZr08gxJYH6lLqyymdOuJrixo/rkeKB8EsrSbhBhot8XYEahncsQZfu6n98qg28KMsHJ7GQJ0QW90PBD5ZnnLrforOqnYZ/tqQjCC3QRzkzYO1b4PXWiFTu3B6lNbGzkrx08qw4rmO2yOuYO2EOIe3dtcz6ikrwU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/1VDfGtf3S2MZ8btoAYzC4BV1byFBUE2AxnQhKpir8=;
 b=GU5iYVOuoI3TYg+C0ckbSk2CQRkkXN9ivd3H9nYQamuaiGcSH4tN4UoV0Vtj9T0gBtfyB8LAY2kiLP+gWyWrWVeggmxF6ZoIEGumjLVcEnYPULkNsZ/uRqJVLcenFKsbdAWulhOJHJk4AwFYfZzK/PeYnU/Sep2DhXpIswCL7v+NThJ17ErurzbFvJavA8i7cGKuKB7nqfQVj2Uxnc0CHpDwz1lrxWQ0TjVEcuWKi73TUF0epbS1XDulPiacPZn71txhMk+lGG+CC7c+38mH0gSps4ppgJn8dsaji7TxW5TE5SfkQr4ikBbHsagf6JIIeYQkR7d+WcS92h82dQ/yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sat, 28 Oct
 2023 04:23:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 04:23:43 +0000
Date: Fri, 27 Oct 2023 21:23:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gregory.price@memverge.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH v11 20/22] cxl: Store QTG IDs and related info to the CXL
 memory device context
Message-ID: <653c8ccc68787_244c8f29495@dwillia2-xfh.jf.intel.com.notmuch>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <169713693022.2205276.8814476945721343862.stgit@djiang5-mobl3>
 <ZTvwxkOg3WCW6RFd@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTvwxkOg3WCW6RFd@memverge.com>
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd19c5-35e9-4883-226c-08dbd76dab3c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gduynDqYZkGRwqZdQ1Ppok86qQPqX/iiFXyBZ36MnSaCPX6L6dKXbOJfOuLuNbWyuVCi3Wyl/IM2uE9PfGrZx+9J4O/c5SuVKYqHkOKqniyu67x4Ez+Vjz2fx8IvY6WIWNf/h1QVBKRVj7xWlXz5Q9x3wPkgWUc7KQXJzGPlqOWjwEFfLwloxGJ7+T6g+81jgKnWhuVyzQPFdZsYefKxG1XBilHXWeL4PnULkdI1hwDm5XDPaQRUjZuoD56Z+qnD12kAnU67SMSr8uZchA+IiuhOJzCzf4DfB0HzGK98z4Im3p3jEkLZgcZVs9se3WvsJkFYUtId7sS0rQ3YNrvSnnRJoLO8lkbcPwlzoYjqQwgczzD0bp5UoO1WzOKnjmIqJcEGv9ipmOXV3wGyciciq3te5Ob72kX0KZr0gVHh8naAwhJM6otEFTwfGXdr/JrU/QWXU8F5bi9/BbCxLy53v9CfCzhudTmwcQprzYuZpkq6UgE+mDZowu2p156vkYxxVKVuynnUMDn6jd/rLApqgHWbD2buuknZJ9s6WWgaGN2acISBQ7Wf6N41AFjXLL0R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38100700002)(83380400001)(4326008)(2906002)(8936002)(8676002)(6486002)(41300700001)(82960400001)(5660300002)(9686003)(6506007)(316002)(6512007)(6636002)(110136005)(26005)(478600001)(86362001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leYsDNp1iRTMi0wC4lfYjsH8r6qNYZGNXo60NWzAR/1qPAmQOzovWMnvUF1s?=
 =?us-ascii?Q?P94VgSKLGZ2hGtuMfiubxgYA7DNwgGeOHGMv+DI5R7IJ/2LlBXZ0m0F8P/qQ?=
 =?us-ascii?Q?yutHgtOkhQkM1eRhy0ehWIHEB4e4++5MNhONJLkjiIMf4MRMBrSgND3VBw5s?=
 =?us-ascii?Q?sck/v6EOkPw9m8or/7m7jHKGiqzwBOtESJKVzKfUykUpew5DPX9Y3AAaOMT0?=
 =?us-ascii?Q?XH992HBZQIdrQ57Jfk3kse3KOIX4AkDUF0RcuHUWpSF6aC95E8nuYhYfT+C+?=
 =?us-ascii?Q?8TOFQaULw1kRrGBpt7k+AOBITrKqaZlOUkQ9ePeEg/csljbhQLbbrT67rUa0?=
 =?us-ascii?Q?N0hhL1NHu5R6OWJdgdaZsX3Dt+XnaSUTLfC0EcpMiGnzgStswigsO+mTo9i2?=
 =?us-ascii?Q?vATiR0h3PPtFSts1JQv5ytTGfHPSm/HYaCsgZe/BNlldlInUw/zfjsvJrEUk?=
 =?us-ascii?Q?qV1/X1zrUaFu215QfbON+M9zPw3gX6IUw6mBsMHv4iy30omY0gLRMIlCKEMA?=
 =?us-ascii?Q?hcf8uQCnmNp0jymcEK38ZuNzZx9IYIq/vZB047PK/SpPUoqvXP4RvMdZFAeI?=
 =?us-ascii?Q?gM40ipXACHtWJi7zpTH4ShI+qd15RAcBeXOhokqGHr79hGDUGCrFUeWymcl/?=
 =?us-ascii?Q?jVh2OBhdnDEjXB22OZhnz4ZkHtb078HNrL342AFXeSXkwaKnxN4Q/6KvDrgA?=
 =?us-ascii?Q?5usL1fhqECWDAUU7ydv34XDtGvxC48kHTgiJQcQDuhx/1PCnEx2xWiqsi0Og?=
 =?us-ascii?Q?/KeP6hJ+dGvdjcxJLxM88pTBy8/IuicFLbF2iYcfVuleTHK0Vx0f14NFeqWl?=
 =?us-ascii?Q?t0CFQGBdhVMipdrKXKxpP6I16PjjWz9gUUFu8/ESirGjc8AqIRmNiVC8NlSp?=
 =?us-ascii?Q?qEcAb0UusHpBgh5gAuQHJPVzdLX5klOVC8gpJE42oBvVHbBKjQy6e1z4n+8x?=
 =?us-ascii?Q?qNs6LNzqe98oPiyHNUW2W2h8JW+n+tr6oVPf/EEwxSdnvAoA6rSUsvxyx9Wz?=
 =?us-ascii?Q?+z5wEZ7PFSOffvTj8bybtcnlpQZQToycRwZL1q/3gnn7vlLku2lWSydX0ZoP?=
 =?us-ascii?Q?41n042yVlRQtLpfE1Frid5VnKD9jCDQZZtICvfI5ieUAxaaGL1hnT58luvEY?=
 =?us-ascii?Q?Sc4/aPtcAEZ1K6RGLmpa3wG0stBIfTYnzu06ONwksC4qivOSXNTKtxmVsDXI?=
 =?us-ascii?Q?c+GEeoSF/YjIfq+YbPVNFu3l4i85t1EcZFaMLqNAA7A/5f5wquPpjbpulZuv?=
 =?us-ascii?Q?r5dI+2a/9IRXhihyxn1mvaU+NWuR0pwSihM0ozrN1wL2KT2HgolAu9WVWPAG?=
 =?us-ascii?Q?VFjxF3mHzVVT4xRWS6GCJUOoB2QPS+RESgi/1mDJILyQf89WYZmcq79SYFob?=
 =?us-ascii?Q?cPb85AGuAnsYNjJ9oEhcuSIvC3BkpANodp2ehp1uyiGoakmGdsrZwk0h90aN?=
 =?us-ascii?Q?sW1aKDuaqlPJKb/kd2I2Q1vYhndGi+Bl4QUG/qru0XNZxpSe8x8c0NR5YFTm?=
 =?us-ascii?Q?+eIt7HP6iLA+PMGf+zqH/7M48l9HGm0MfPDsccI5fETJF6GabHj/oWqTTTkT?=
 =?us-ascii?Q?W0xXSpeTUWmksgSRO9K9i3hA4IfF/FOsllgV2oxAgr3GcPCC9GW3Id7MUIM1?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd19c5-35e9-4883-226c-08dbd76dab3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 04:23:42.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/yRU+xj7x4EV47+G4l2TNE5ywLB2+Dd227otS9il99Oqu/o0ZeeepOg3ctMo2Q6S01/kklv+UBMAN0bo0BJjspUdjPg+NNqUTTmAfk7Lv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Thu, Oct 12, 2023 at 11:55:30AM -0700, Dave Jiang wrote:
> > Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
> > the return package. Create a list of entries in the cxl_memdev context and
> > store the QTG ID as qos_class token and the associated DPA range. This
> > information can be exposed to user space via sysfs in order to help region
> > setup for hot-plugged CXL memory devices.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> [... snip ...]
> >  static int cxl_switch_port_probe(struct cxl_port *port)
> >  {
> >  	struct cxl_hdm *cxlhdm;
> > @@ -196,17 +239,22 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >  		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
> >  		if (rc < 0) {
> >  			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
> > -		} else {
> > -			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
> > -			if (rc)
> > -				dev_dbg(&port->dev,
> > -					"Failed to do perf coord calculations.\n");
> > +			goto out;
> >  		}
> >  
> > +		rc = cxl_port_perf_data_calculate(port, &dsmas_list);
> > +		if (rc) {
> > +			dev_dbg(&port->dev,
> > +				"Failed to do perf coord calculations.\n");
> > +			goto out;
> > +		}
> > +
> > +		cxl_memdev_set_qos_class(cxlds, &dsmas_list);
> > +out:
> >  		cxl_cdat_dsmas_list_destroy(&dsmas_list);
> >  	}
> >  
> > -	return 0;
> > +	return rc;
> >  }
> 
> This causes existing devices which do not have _DSM implemented to fail
> to map without this QoS extension.  Please consider having the
> cxl_switch_port_probe function return 0 even if the QoS changes here
> fail so that existing expander mapping continues to work.
> 
> I presume future QEMU implementations will have the appropriate _DSM
> acpi field, but older ones do not.

I'll drop that error return for now.
