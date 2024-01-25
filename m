Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89310A0A
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154595; cv=fail; b=kxk5bDUGH+vC5VPzstPPecPv009M8NZ88+hz8fHPMjHEzetCVW4SXcsCm3wxd8TytuRy7CuY1DpYtPMJCmJQkW9PP7HtlhOBF0liKklzwAVgzYDtN+0luRqO4SJYTnV8aqcXFO0l6ugwRT2cbVsb+irCJtP5lr4nrlqmOEHqv74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154595; c=relaxed/simple;
	bh=j2M70Ygk4zyoIC69Wn8WknMzAyy2pwdjhXA9l+PChww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R46j9RDKPXO2LpYbGdSknok4s/I3lmABIcTmnvK+rpwocNl46FMPyocB9N8MDcXAT8xBUTlMnEEiM0l7MaDdH7OZm9oV6cFsHYEbkIadFugfYO3kZS+b8gjQWZ7Q1x369sNXqWFH8cLag4J5eEIeXAvRcFzENPkkFv4ziBmaF9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKHhHNPN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKHhHNPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706154594; x=1737690594;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=j2M70Ygk4zyoIC69Wn8WknMzAyy2pwdjhXA9l+PChww=;
  b=GKHhHNPNmjZZG3+LBLkxnLgclNlstAWBKH0tvbjKpJzFhzwtAGVJ+7Sm
   ULJ18ktri4x1gmlhHBaP94Rus/3AtcllGauXGkbw4gt0sPrCfHdE2JZK/
   k1Sa6NPuoHhUkvZbnanrcxlbd66TcWwINEuQNWRRiq3+f3i+a1oYclOiG
   yXCr6OtA8M3tbehMhaiQXAbeSE410prqAGnRXC7z70Ra/BeXdC6R0DTjt
   3ooU1kKnJOvNpR5iflxUzjktNGcYUK1sxTIABqtqTiU5OwdVdDtBrPn8l
   bjbQgZBlJ6L68z6QD5pU6N+uMbooiEzFh+ShGGGskwPDIpbKx+/e1WvUG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15583563"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15583563"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 19:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905833653"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905833653"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 19:49:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 19:49:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 19:49:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 19:49:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVOE9QXLofOZRKY7DdJz1PzpRm9pSjMmsIItqGeCj8Jp1sJRS/tAVLgEFdu7oyvo9iO8aVb6ZcGVush2mxQUy+6GZAwUqCeXpY0CpAUZ566DyHHi45A2F/0qwEEjZd6NOa/Y4tya6kl59RAQYnOkY4F79E2CDL4aOGiLRxYnheWC5meCr7GqmfYqdoRmP7uFXTAGEJqMyFky99/ZLsAlps2c9cinaykiXHQDMz1W2itGQv1vor/RwfkV8gFumqE3Ku9D8TCRaaakzEp1ncAKY45yHRVnKFmDPHsrOVjtVHqPMHojJzNRoBd76pFOPcS5+cS339HU+1F7LwRTi/YFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMOwsc+wIPISgvzYnP7eUQhmrU2+bGPIxB5LOYdvlu0=;
 b=n78+pQx2DDXLNmCOWrczEkVOot5l1Fpx4iT1kRti+uoFIRBM8k1/OK+4+BVVcY9i5wPon46b+JSfrE3tT/ck8GJ/TW4q8EAmq7DUNlqzEmc6Co0zGk5pfzoUcBwxiqyPYk8OHutAo2XFEBnr1ZaaTZJVkYlKSYzQXpYH1EkNmDG31f+s0beNWpBk1AoF0DsKbj9BRZF54cRxoDCJtxstSsrEhAhaSfz0CuKVxrtu70Bt+0fBnOfQNadUkr5MmfJqZRZ8yRQzBay7+a3q8//5pK5Zm2Gt/GwUuH5fUZ4MZdqHWU6lweGbsspjY1Ah6c2T0kunt9igatfHhpQ6LnahNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Thu, 25 Jan
 2024 03:49:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 03:49:49 +0000
Date: Wed, 24 Jan 2024 19:49:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <ave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Message-ID: <65b1da5b2933b_39fcf29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
 <6595c83083418_8dc6829468@dwillia2-xfh.jf.intel.com.notmuch>
 <a32d859f-054f-11ca-e8a3-dff7a5234d0a@easystack.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a32d859f-054f-11ca-e8a3-dff7a5234d0a@easystack.cn>
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c505f72-be29-45b3-9250-08dc1d58ae0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSkgXlxEzXinpBjg0uAedo7zZZSFNLSpOBa2HEjFMF8rOkBcjnqlbNH/p0A6ML8mpAFjvwebXuy2DLrxIigpSIzgMuVjc6Ce08d5QBhMfZ8oa0lVSmp5gI7zsZdHN9JmUzcjBLPm9sxyheCmwyN0zdxhTbuXhC0FCtb6c0HnXYgN9w6u4QN4naxHvfHg2lDQ2KCUHUv2/rc7eEngSjPiw9W9R/4Fjt6KrO1lxHMxsGYp1CLHF6PCjzQ93tHUnKedAj12F8jlVWXkQeznrB8Y86r6MYS4BhVOcASvVhCCxvnhd/xV+tMGYak/FUzAovcMbw6aaQ94jp4jq8A0ejqXYvim9zyjYezwX7FMif/02j7x67AvpkbooJ80jjNPRn0gFay+2SjbsTfpuS/lY9SR7e15qsYlL9Dx/ehCctwv1Xu8KUD5JTgaUBINYDocuFFGq3yoe4KBqJZ3ojs9OyFw+dbhZXXKleOEo1ycEaM2Mxlhy/pLU0BcM0FwikmWD4JHrypPcvPnI33S4L6vhq9rXxCuVfzoSEmsPPBDYHo8ZJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6506007)(82960400001)(38100700002)(26005)(110136005)(41300700001)(6486002)(66556008)(478600001)(66476007)(66946007)(6512007)(966005)(5660300002)(6636002)(8676002)(2906002)(8936002)(9686003)(86362001)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um15QmQ5amlXWnk5VzNaczdvQncxNFhCOWlPVm1rSHFyTlcveWhoUGhiWjEr?=
 =?utf-8?B?T29LTzRZL2pDbE9FYmpsSnp2bWJldjUrRkdJWFFoUStyT0NIM2MzNTJoaVJW?=
 =?utf-8?B?WXlpZFdRcUVuOTFoSUZCWXhld0I2MHZ4QWlVeFJtWkUxUC9SNzhRVVVyUnBw?=
 =?utf-8?B?VlZWSlBZZGVRUVltZkxBMldnQmFLY1poSDUzaEp6YzhxaTVTbWYwMVdmeW5s?=
 =?utf-8?B?YXYzeFlPc3pmNEVNVndOQ0pRSjRkMnkreitMUG5pSU5CRWRnL2k1SHkvY29n?=
 =?utf-8?B?QWdSR2ZNOHV5SzN3V202YWZKV0dyVUxiRUx1VTNOZWJIWUxIbDN2cnZ2MEtI?=
 =?utf-8?B?djRBMkR0MXU0dzREMkR4dGQ5YTRCRnBuQk5ESndKWDNlZzZkVlBiR0RjSXlv?=
 =?utf-8?B?Y1l4bG53WGhma2JhbWxmTjRSNDEzNm5FV2JCTHN6SEp6YVNHWEpYL3ZQeXRh?=
 =?utf-8?B?RjRjM3haUDZOUGptbmsvUUxNekUxeDFhNVA4Z2wrNnpOYUZTN1krcStNc1RB?=
 =?utf-8?B?aUNlQytON0o2ZEdSWFlkU2F3aGJ2bkNVRFJJZ2dCbG9wTjVnNThORXZlSXBo?=
 =?utf-8?B?M3g0dUt6dVlWYXN2UnQ1dERaWCtOZUcvSGxwVENIdmRnMmIxdFBKR1A3KzBa?=
 =?utf-8?B?OFlXVmNYTjhDME9uZ2Rjd1Z0YTRqRUVqTkRuRVRQRG85WUVQK05NR0h5ZEVj?=
 =?utf-8?B?ZFBNSFFPYVFXMHJBTG41Vm1FU2JSRTczS1c2cFFFSnJNN3B3RmV6TVV3SDIx?=
 =?utf-8?B?Y3FxOUQ2dUw5dE5vNG90Yi9nUHVnR3BNTlNXOGVmYnZ4eUxLUTFSU3hsY0tm?=
 =?utf-8?B?bHFHQ285T3RrTDNGVTVRb0huNkhKZ3Z6TnpJb1orejZGNXJqUnZZOVJPTllw?=
 =?utf-8?B?Wm12K3hwRXVhRGorUEpnUUpxMWl2dEZLbkc2WXhURGxwWlBFRnBFcE1vSXJ6?=
 =?utf-8?B?UnNoaG12M1o4SzRGZlArK1pWeUNrZWtpbTlnWExBbmFIanhwUzFOUVo2aGdZ?=
 =?utf-8?B?dGFJU0FaRGovVjFEc3dZZUMzQmVMTFZwTjZRMFRDMFNHbXJSWWVxQ1pkbTRL?=
 =?utf-8?B?cGZDek9qUHRpd3ZsV3hWSTNtaWg3SGEvbmZVMlQ2cWJSVjJVL040ay9HOGZU?=
 =?utf-8?B?cW1uQmZXTWJreHo4RGtlc0cvdXMzK0piNU4xVTZBb25WLzhaV29qMWgyQ2RQ?=
 =?utf-8?B?b2VmaDd6N2hhVm93OWdKeklCNWVsSXBLODZqeS9QY0kvdmpVZis5L1llRFJ5?=
 =?utf-8?B?WExoemRwdjU1YlZ0WUN0REJ2TGl0MHN1ZTFuL1pTVUJVUFVWMEs1QnJtaVIy?=
 =?utf-8?B?WUt1RTNiRWdzaGExbHNXVjF4UCt4ZEsvTHNiQzQrd3hXMUhjY0pOQi9kajR0?=
 =?utf-8?B?YWVwYzQ1NFdMQk9Qcjc0eHZkcDljSjNreUNvZUd1YWV0aDlBQ1JJbVZiNWlZ?=
 =?utf-8?B?aGt6NVJnc3dUVWFoWGZFcElxTTR3ek5ZRG9uTlhQdUNTN0JRRXRrSXZnckdN?=
 =?utf-8?B?RHlQSXliaUhBbUl0MUpCMS9kdm05b3ZEK3FUMzF2dzBZVHdydVRzQzNyVHhG?=
 =?utf-8?B?SDgwcGFqb20wOG5ScmZpaWttTloyd1pkYTdoc0duSFdzWTFYdmdLOFRadTRV?=
 =?utf-8?B?aFRrYjlIZU8xM0IrbUJabUtlbE01RE5LNGZURG5WVnhMSHZncUgrRW8xVGs5?=
 =?utf-8?B?M05uRitJQituQkxJWEhqdHJERCt5SWF5WmtPMUZVRElLNVE4dmI0NXZVeUNZ?=
 =?utf-8?B?ZVBqcFpZTDBuajVwMHlHRDQxK2YrRlhMejVQTU5peVkrZ2tyOWxuaUpOSkVp?=
 =?utf-8?B?bVNTQWFsY2ZYZUhseXBRM0UwRFpTWWtuVjl5RDNZQXNTNWNtTmEwODBmMXpm?=
 =?utf-8?B?SmxESTlURUdaZTZnVTlaNGEyTmVXYkpzZEdVYkdKQkgvV2t1d3I0anVjTEM3?=
 =?utf-8?B?WnQxTnlVMURSalQvVlNkeHdGaGJEV20zdGhhWlIzZXlpL1FSSVRndFppV1o4?=
 =?utf-8?B?NWoybkc0YzU5U0Jic3hSNEVLTU0rREFEL0h5SWlGK0doSnBaZnlseXJjV3dF?=
 =?utf-8?B?SHdYbHl4MUwvU0JkK1JQN1BuRlZNOWFMZDJqRWU1NkFsS3VIUHl2TTlOazFB?=
 =?utf-8?B?UGhKL3B4Zk16NmtXaGFVS1VzRXd2b0xhWXIzWlFDZzNHYlhuZ3cxQ3FUbEFF?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c505f72-be29-45b3-9250-08dc1d58ae0e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 03:49:49.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5vlULq9ePj/bCVvWrAmHhWDF6Epv7LzFL4Boom0D4eWH6j0mS9Ng+OowClBjLTCDyAPWTCZfrCOvpf9ORo/aXaBV7KvGC9NWx57bFQQmZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> 
> 
> 在 2024/1/4 星期四 上午 4:48, Dan Williams 写道:
> > Dongsheng Yang wrote:
> >> Hi all:
> >> 	This patchset introduce cxlv module to allow user to
> >> create virtual cxl device. it's based linux6.7-rc5, you can
> >> get the code from https://github.com/DataTravelGuide/linux
> >>
> >> 	As the real CXL device is not widely available now, we need
> >> some virtual cxl device to do uplayer software developing or
> >> testing. Qemu is good for functional testing, but not good
> >> for some performance testing.
> > 
> > How is it performance testing if it's just using host-DRAM? Is the use
> > case something like pinning the benchmark on Socket0 and target DRAM on
> > Socket1 as emulated CXL to approximate CXL bus latency?
> 
> Hi Dan,
> 	I give an example as below, please check it inline.
> > 
> >>
> >> 	The new CXLV module allow user to use the reserved RAM[1], to
> >> create virtual cxl device. When the cxlv module load, it will
> >> create a directory named as "cxl_virt" under /sys/devices/virtual:
> >>
> >> 	"/sys/devices/virtual/cxl_virt/"
> >>
> >> that's the top level device for all cxlv devices.
> >> At the same time, cxlv module will create a debugfs directory:
> >>
> >> /sys/kernel/debug/cxl/cxlv
> >> ├── create
> >> └── remove
> >>
> >> the create and remove debugfs file is the cxlv entry to create or remove
> >> a cxlv device.
> >>
> >> 	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
> >> will create a new root_port for the new cxlv device, setup cxl ports for
> >> dport and nvdimm-bridge. After that, we will add the virtual pci device,
> >> that will go into the cxl_pci_probe to setup new memdev.
> >>
> >> 	Then we can see the cxl device with cxl list and use it as a real cxl
> >> device.
> >>
> >>   $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create
> > 
> > Are these ranges reserved out of the mmap at boot time?
> 
> Yes, it is reserved by memmap option in boot cmdline. I use memmap=8G$8G.

A faster way to get to a device-dax interface fronting reserved memory
is to use the efi_fake_mem= command line option.

For example:

    efi_fake_mem=4G@13G:0x40000

...assigns 4GB of System-RAM starting at the 13G physical offset with
the EFI_MEMORY_SP attribute. By default the kernel creates device-dax
devices for that dedicated memory.

For dax mapping performance testing you don't need any of the CXL
driver infrastructure since the CXL driver has nothing to do with the
data path.
