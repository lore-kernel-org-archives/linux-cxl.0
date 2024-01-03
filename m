Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE41D545
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW2ZXMuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704314936; x=1735850936;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2cqvD5GJ0cA3vHdH/bu0hBVu3nck4tVFVdKjnXRlXeE=;
  b=iW2ZXMuSHtyabxPIl4fD7korNNvD9CUG0IC//6bYQ8HfByejIaRi+6GX
   ak0x30665vaqch9laO6TT83PoVPYyMViZ4K+g9Fi/wQNTj13cuYJSIJ4I
   kJJHmwZIreH9EqwiI0FSB2nnl0pj870Dkc12kvntlWPKYV9j58ucpOova
   GV/HMY8WJjbzETafIdwOuAu7PvS4JaIT4AHMC8oRPV1pHzxXGUjtbqaUm
   OPEaNalTS0A0YWJZIniv8ZZeI3DG9nJ6borKMhUeMhb+FI0If/LyPr+/k
   TsUl1HY2amV7sMUYKnfsBmdzij3xFd/v7XunBnAP+3AFTn7itD8a60UE0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="428235888"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="428235888"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:48:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="783614889"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="783614889"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 12:48:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:48:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 12:48:54 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 12:48:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxobdDVLBSWlnwzoXudml/NJHIyeiDV1nXYX72bs/F4hXYneeuwOlhvAiDRe+3J0FxKGsx64JHHOGAwxzktDwMzGCXrUsU9DqTfY7/XT5TFLEIdaUjGV6YRQvpVZRhddFNhHZJ5r/9WB18cwTd1TF+UaNGmqBlTY72x7LFWnxPvhtCB1rKPH0emArteTfYs25RbdsD+FXqRwpQ7+0LfNhB+qQXptq59H1kaNIfCVibkN9tqrdWYCN0CL/WUe5CFhOu1RRlbQmiFJMqD4Xkf8K2xKYv8dmRn6C67KO939VkaGPkkP+O0qa0YLIsINYjqRH9VviS9FLzLxII9fjbDoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX6FV1BlJRt2xfE5ooUwcgkVqKWLw39oxVwpwKtzZNs=;
 b=NN6+NchtClmx1ld3pLzBsgXeTZKguqKJIdvtxrINpsx6rVc9QwWpG0TBo6IQ8lHo1QY2gH+zT3iP2FQew7IUL9qpyvXqeEsrwjI01sdAlaXtjRPJGxiDIg3ZAENmXxVj5RYd6+0BpLFd1l80WE6y1g29sahrgV7/MOGH+hDiqoTp2wO+uxSewBsV1397fzQzvhPmdM8GkvirPk92Y1nQBp9yXr1S8A+z8LGhQOUtwIwhothZmUygBrP8Z7S3B/LYhmf+DxKBQEm+LF+5gf/ee7GKx+Y9YaZkWdJkkNQlQnbopxi/36oUvjBLHtcNxtE60KjV8Sk7/4rh6C+hZp32Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 20:48:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 20:48:51 +0000
Date: Wed, 3 Jan 2024 12:48:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <ave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: RE: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Message-ID: <6595c83083418_8dc6829468@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
X-ClientProxiedBy: MW2PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:302:1::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e55bd5c-4f01-4287-46b2-08dc0c9d645e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnyPXDKwH6pOENVmRoWKroW4WgDFx5F1Sdz54s/8PTAQrtnz6+Bxqu1cvKnuAFSaj5gLqWelzROLCri84B2XINjlx1Jy4Ikl+XD6mFeT/cqKGszqNRe6s7eBeSm0TfKQ8M4O2911COsW51D783+00FA2RaWyFhIK/2+0AsE4JJTDlQsF+ISC+dFxZ/2TQ5q/Xuiv80WoBt+40lB96Pj5pYzAGdwWmvoR5mr0ulnvFrqF4/OaZLh35JNR1BMtmh+bMK3kIsmwXuzBkE4LuPjPIAdSkj6iUcvhef02EK1oQb28V54w9/Aogv7+HXVSscc7QEBrd4nqCBobNR/v3Y8bfAhOI2l43t1GbricGAd3qRNIPsfI8hgcixcubBUSswFt8bnc/h6RZLVRfwCbnUkHwBb2WVPogyO2HyKjU2Ny4iIE/6c+AQjpIokBwKBGrFp+2e+CGUCx9v939EZienwLzm4VnYqJg77kRzQW1gLbgSlRWh4v8Of4CCSG959p2H56jPa5jck1LfnTlSYgS80NLqA/X0+NLpE4MMBQcNUoFec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(8676002)(8936002)(478600001)(66476007)(316002)(5660300002)(86362001)(4326008)(6486002)(966005)(9686003)(41300700001)(6512007)(6666004)(6506007)(82960400001)(66556008)(26005)(38100700002)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVlqL0ZYNTlFcG12L2pUUHNjVnVLeWljL0d5NDU4OXU4c0JUeUd5ZmZ4c01s?=
 =?utf-8?B?OU5HRjJ4aldWV1UzaDd1OStvQkQ2N3lTK2hmVjd3RWlPN25MQ25oWmNhd0xk?=
 =?utf-8?B?Y0VlTUZTS3VER29mZVdnY3IzMUM1MithcW5tSlRkcENvV3pQbEViNm1mcExI?=
 =?utf-8?B?TXBYSzJXUXZxWmlTRStZSE1BSkdkRUtCT2I1dTh5dFJYaWMwd3l1ZkdNNExP?=
 =?utf-8?B?dDVxVGtqaXFNZEtnRmRxMHNYRVF0K0s5MU9qRnZEVU5XazdTUmNWSklvNzN5?=
 =?utf-8?B?VU1FM0pjOXd0b3FJZi9FTWhyd0wvNzViaTBNS2xIbk9yM0JQVGRKbk5uR1VC?=
 =?utf-8?B?YXhyeCtiMHY3b2RZa1VHTkx6ODZib1J4NVFEajNBNlNHMWRXanJ1SnlBcStJ?=
 =?utf-8?B?djhrZ2E1UDVSZVdWZytLK2taak95eEVaRmlNcVZJaE9ZUy9uTkpxSVp1ZVBH?=
 =?utf-8?B?Sk5EQk9ORlkvUVQvdjVQb1JkK3UxamdmZ0toZzRWMTlsR0FPdm1LS056dEh3?=
 =?utf-8?B?Zy9rUVNwb2c4L0NJTHhKOXZVK1JrQkFia21NSTV2Z0Y5MlpVUzNKcmVWbXha?=
 =?utf-8?B?a2NzQkdVOFFDNTk2RFdFSElWODlGTEFVMk4vNzBWWWdpanUzNGg1ZmFKN0cz?=
 =?utf-8?B?WForeGREVVdwZHRZY004Vk5mQXJHblZQQndMUEhtamJTdFZ6VXp5V05kUy9O?=
 =?utf-8?B?T3VuRFhFdUZMSURMQTFVVzllYW1VcytvbW9ZcjBUcEYxNy9Bc2VNZXVvYzFa?=
 =?utf-8?B?Q0EvVi9ZVG5JelBscVl1OHZBekc4UWN3dXU2Q1RYcHVZY1MvVGxtNXBFTFdO?=
 =?utf-8?B?MVloZlYycHRvT2o5TGhtMElQZnFMeEpBRDFaM2dTZ2VMMk9GKzU4aDdJWXZZ?=
 =?utf-8?B?ZFRNV1E5R3k3ZXhHMldSUGNQejBvd2NpSWVlMGRBUmJEVjNCV1JGYUNxSm9N?=
 =?utf-8?B?YStycExrcUI2dnFDWllGTlFyditRaEplUWJSLy9BT1Joek9RdGRveFVOWHVK?=
 =?utf-8?B?aXlIdlZGVHhMbG1ra2MzbTR0Y1l2akFybjh0V3E5NnNndC9YaU9mbzhKb3Rn?=
 =?utf-8?B?RXF0eVpJTmtFSkJiNm5vdndLMmRoVFB1UHBidG1TdWVvQzg2QU04TjJLSHp6?=
 =?utf-8?B?L3plbXNPTVFmNG14dUNHdXcwb2NjRTVaWlBBTDRpaGgweTRUMys5WDE1OVNZ?=
 =?utf-8?B?TTJwb2QyVUExSkFmYmhka0FTMWVwdXgxU3daeFcrUjFHRlY3d3dqVlNHS1Fm?=
 =?utf-8?B?T3d6c3orazBlTVFCMjE5ZlYxS1FyZWtiWHZCNE1yV25QS1JCKzZwZEVSSnZB?=
 =?utf-8?B?c25CMit4L2djT3dNdm5GRUE3S0lzanFITXFCOE9lSGxLdVpNU2U4NDhqOXlh?=
 =?utf-8?B?SE9RR0tEUGs2aWIzOUs4Y240S01qS2tEMDFnTmNycVJDVithaC9RdmVJbTVw?=
 =?utf-8?B?d294V1luTXM0S2NoZkJqK2hlNjJ1NVNlNDE3SnlQZ1pDMG1ZZ2oxbzdSMmVQ?=
 =?utf-8?B?U1R5T3JQTXFSby8vaGUxdGthMmhlTzdPRXl4QVVVNjhZV3Y5bU5ZN3d1aEhN?=
 =?utf-8?B?NlNTa01yOXpZaEIwUTJqRk82Wk1YQTZlak9yam5ka1pJWVBmMklHUVJOcW00?=
 =?utf-8?B?Z2hweVh2T2R0VVdBanU5YTE2aUc1ZWh0azhiS0NZRXFIakhlcGovSTZIaERk?=
 =?utf-8?B?Q2VXQitWWXFhK1I5ZEl6Z0xHTzJhK2JXM1VHM2paWHREaTRMdlNvZHJkcTFx?=
 =?utf-8?B?NE9lVUZoUVNnZTg4Q2VnaGVUak43dk5ZVWZiMFlSZ25aL0pWeEZFZXVkOURX?=
 =?utf-8?B?N21hK2c3ck1wcDNDazRENkFMMEM3bVp3TWZueGUzYmtZd0w4cEdYUXlsNDJT?=
 =?utf-8?B?cmJ2Nzc5TyttMlF5eW1XMGVJbk83U2FHazBGc2VWS3VqdHRxZ3N2VzBURTNT?=
 =?utf-8?B?WDFkY0czRUNlYzhRN01ZUDBzdVUxMTAvNjRSbHozbG1WWFpMM0t3ZFNjN1RI?=
 =?utf-8?B?V01XNjNEbXlMOEx0UWc0RXl2L3puQzNLcDhHek5MNEFWNE8wd21oWjVjSGpo?=
 =?utf-8?B?QnJ3cWV6eXltTWFlU1VleVNIVXlwUDIxbVZ5c2RQK3VmUlF0U1UyTllKYnBL?=
 =?utf-8?B?RHpFVE0zTUdzYVUxK3d2UGt3M1IwN0pZNVhxeVhMWCswekk0ZkZmRmQ3amNW?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e55bd5c-4f01-4287-46b2-08dc0c9d645e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:48:51.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiZQ1UG+HL7eUR2/e0bSlWE37CbZMfOgmi2qMJm5EivhfSPyeGJR9SdODffXCFHOHz4Pb+nnb0QGVRsrJP28w1jReARnwUNcGbvWcohRhx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> Hi all:
> 	This patchset introduce cxlv module to allow user to
> create virtual cxl device. it's based linux6.7-rc5, you can
> get the code from https://github.com/DataTravelGuide/linux
> 
> 	As the real CXL device is not widely available now, we need
> some virtual cxl device to do uplayer software developing or
> testing. Qemu is good for functional testing, but not good
> for some performance testing.

How is it performance testing if it's just using host-DRAM? Is the use
case something like pinning the benchmark on Socket0 and target DRAM on
Socket1 as emulated CXL to approximate CXL bus latency?

> 
> 	The new CXLV module allow user to use the reserved RAM[1], to
> create virtual cxl device. When the cxlv module load, it will
> create a directory named as "cxl_virt" under /sys/devices/virtual:
> 
> 	"/sys/devices/virtual/cxl_virt/"
> 
> that's the top level device for all cxlv devices.
> At the same time, cxlv module will create a debugfs directory:
> 
> /sys/kernel/debug/cxl/cxlv
> ├── create
> └── remove
> 
> the create and remove debugfs file is the cxlv entry to create or remove
> a cxlv device.
> 
> 	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
> will create a new root_port for the new cxlv device, setup cxl ports for
> dport and nvdimm-bridge. After that, we will add the virtual pci device,
> that will go into the cxl_pci_probe to setup new memdev.
> 
> 	Then we can see the cxl device with cxl list and use it as a real cxl
> device.
> 
>  $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create

Are these ranges reserved out of the mmap at boot time? 

[..]
>  14 files changed, 2388 insertions(+), 148 deletions(-)

This seems like a lot of code for something that is mostly already
supported by tools/testing/cxl/ (cxl_test). That too creates virtual CXL
devices that support ABI flows that are difficult to support in QEMU.
The only thing missing for "performance / functional emulation" testing
today is backing the memory regions with accessible memory rather than
unusable address space.

It is also the case that the static nature of cxl_test topology
definition has already started to prove too limiting for some tests. So
an enhancement to make cxl_test more dynamic like your proposed command
interface is appealing.

One change to get cxl_test to get it to emulate with DRAM rather than
fake address space is to just fill cxl_mock_pool with addresses backed
by DRAM rather than addresses from an unused portion of the physical
address map.

Currently cxl_test defines address ranges that may be larger than what a
host or VM can support, so this would be a new cxl_test mode limited by
available / reserved memory capacity.

See cxl-create-region.sh for an example of the virtual CXL regions that
cxl_test creates today:

https://github.com/pmem/ndctl/blob/main/test/cxl-create-region.sh
