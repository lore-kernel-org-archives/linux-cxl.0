Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A58C61DA4
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 23:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjA3XTB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjA3XS5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 18:18:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22452B0A5
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 15:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675120729; x=1706656729;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qkZ1FrHyAsmNdAJaWo67ie9AoQiAlgmpolNTTcGQT/Y=;
  b=hyfHZSQsXYPQp57SByQZaie1sab8ZTjR74FU/a0AsLzbEYrZsFvsWT6e
   7KfPSVvThcZr8J+Eyz0oRezBoc+Sg/xryIHyiq7Ba5+eRNzZusKjouGGU
   FQpGrDVlEIDmpxFlwwp9uUdoS3wuGrYND1epj+zugJaN7MhE6hP75Mb7J
   A8rcxoFGDOlS6b6eNY0w4TQ9BSJgWzWHbfosxWC3YB2EhGOAuzmV5TAZL
   rgSiXe/Zc0OQWgcVwj4w+IWnzQQ9kfbZHms266MtCay0ktBA7PMY09qVm
   9URio913V0vl1TnCcsjy4powpQMEqiQ/Lhb28GH7mvvq444A6UCHKGhaS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392249212"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="392249212"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 15:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657635614"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657635614"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 15:18:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 15:18:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 15:18:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 15:18:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 15:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTwX59RQyyo+n5+tAQdVAeVV6g+MDawza+vHVCuJxcqmEQMNhtOO71N8YxoZAGj/bG29B+1J0iNugGIpAGCy2/7Q7SOeyuQ+Dcf6zRRxhwx52AnoKQO3vwMpROf90NhLq6wnZkI6smie9GdsGRTp7S3fkoMr3Y5vVNsJZSIu0cFPsVh5xh2UHQexvz4tzkLCEzk1Vm8oBMI5O9ZpEmE2smAq8K6wALNMxayUnWe2APCKcjm09tHKmcCwFVcLeitWe/QQpynrzqsJWQdZO7j/g4iXNmI1Cnmw7GPM4/oA9xkucWdoIMhGQ9dVmoqVcnT/2MEqVj477L0i+V4BI3/RUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QKwdFdH/6QrNTEp2ct2mvFZ4N5ckERQWnO9vxeNprA=;
 b=gupDNoZ0Smqd5TcUb+8w/rk0FBv3kJBuS2xnJtovaySxXndh5OA+qVNUEamqF4kTtOXfpjPBfrFiDOH8Ouu+pK3iXWgh5nXM8uxsabQXe1Sexc61P7uQO/BLgh3nru4XBWVTyoAHVctx7Yu6ss7vk/zESbO7+W+dQTos3N8adAtcXzVjcBHVI5d5lZPZetPp0Qh24pr8hqI316ZXwA+nEj7iaMeLvfhzHWRRh3GEFZDCb5vZ/e+0ue7fteG/WFbVjIECcSfFWMtTUGEoym0pO/U42XNQxWEWbCaV+m+WlFxCjnMsoqDhpB+JdurBeaAUOgYqZwMEwRMp6Ba9jHtyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20)
 by BL3PR11MB6460.namprd11.prod.outlook.com (2603:10b6:208:3bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Mon, 30 Jan
 2023 23:18:39 +0000
Received: from BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::a926:e4e5:d28a:f219]) by BY1PR11MB8127.namprd11.prod.outlook.com
 ([fe80::a926:e4e5:d28a:f219%9]) with mapi id 15.20.6043.030; Mon, 30 Jan 2023
 23:18:39 +0000
Date:   Mon, 30 Jan 2023 15:18:38 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9gva49IPFOXYlkH@memverge.com>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To BY1PR11MB8127.namprd11.prod.outlook.com
 (2603:10b6:a03:531::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8127:EE_|BL3PR11MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e1f991-52dc-423a-b7c6-08db03185229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhV5kmfQECfN1UZQSodO8mvZfHJnN8n7dx/BOPqP75WwfftIdLWU8+qnfZaITFzBcpSOyOJqUgBhLIi2XrlHcAjuv4NgwTxbguRCX+dMefwT4FGOB31928hkXNpVfyEyeGZNECmg4c8bdQL7zUtgFangCNx2Xa4AWYo0/SAHRMLdbn9jz8kzlEtfdJHlWBEyYMMAEWurX+E8xbqaLq7Po7qIo5mqSSa81Ok04vT/G2UmWgrEbbSoBtkDYFw0526gy+w3tAZe12cZFLYxHuxESYVie3sq4EHN3a73cnsclVS4flAom+pjG9E2C0Ynkm08ZXUGLBUff5hFF2SCcJ0tUxW7gwv86QeO2rZmjQXfOV8di2PR7ZpW104EZNfRjssNfm/vBaf9i6nzM8pNbd7yCkjQVUnu8x5H262wLXVEw2he0vxH641gm/kbFUkXkulnW7htZyPDSBo+TjsdvCd32X9q2rJBUubvD/CYdWGQ+J6sY+tgP2ftpvTz6an2NUzXkbRGvw8XJpOqpxEY5p6HNqr/Hd6inBZOTU9iMc8J6iPKbmtjgTgHGfJJcj2oOSeRFdPj8KEJXVQOpeYuuH0kS3esc+SxYcYx2wBOcknrblQp3oe2tc6vlhwPegdaKn9td+4ZScFZ9s6jJ/sZmbVRmtf0EFwQbxq4nhcEfpfvihk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR11MB8127.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(8936002)(478600001)(6506007)(66946007)(66556008)(66476007)(4326008)(8676002)(110136005)(86362001)(6486002)(966005)(316002)(26005)(82960400001)(41300700001)(9686003)(6512007)(186003)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFJjcnRUK2Uwa1FhaloxQXpONzV4NURYSGFwci9vRDZtWGJxRER2SXU0Wkl6?=
 =?utf-8?B?K2N2RmQxYjdPNmt6VEpDNXB2NEJoTzJnYm1wamlESkhQMEZCbUZKaUNUZVR5?=
 =?utf-8?B?N0RudkFYU05FbzZwQUI4RGN5QUV0WFYydUZEcU9samd2S0hORFZrT3NTaGhy?=
 =?utf-8?B?eTJKRktCNm04RncyRmo0TS8zdmc4dkl0TkV6ZlNQQk9SN3dHQm9MNW9iRDhL?=
 =?utf-8?B?WHFRU3N0V1ZkbUlDUUpzSVpJOVRBTEtrRDg2T0NFVisrclJZSDE4bFF2cjYr?=
 =?utf-8?B?SmlKSitQZnlCNS9qSXJQeVNIcm9NYWY3T1NFRDgyTjN1NTJoU0FGd2hKY3hW?=
 =?utf-8?B?dVY3c0lHeXNkQlM2R3dkaU9KYjY2ZEFtZ3ZEejY4UFlRVjdWdlpqbkVRbXFC?=
 =?utf-8?B?ejBqaEMycCswalhmYllyYTFRK1VsbGtWeWZ1emNuTjd2N0lqMHByS0tsa0N0?=
 =?utf-8?B?VDlEWFZHbE1UREpzVzZtTThYSE13S3dybnhZSVRPc1VBZG5JaVkzWkd6VDZJ?=
 =?utf-8?B?b2ZsUTkxNWppSWxRVUpXLy94R1R1aHo5TkQ5bVBIaXRRVjAyeXBFSmVIRHEy?=
 =?utf-8?B?ZkFNQ3JnNFI2cGhHRndnWVlWbm1KWkFHV3FEbzVqajl4YmFPckpOdW1ReC8x?=
 =?utf-8?B?M3dlVHZ5M1lrRjlhMkorbzBxNlJBUktpUFRIdjdpbXp2MnN1MEVFSUc2M3BZ?=
 =?utf-8?B?YjlOZjZDY3VzZFRKZWdNOWhrUCsxM1BOa2RJRzkzc2s0QUtUNnN4ZEtOSzZF?=
 =?utf-8?B?c1I4d1VZTi9TNFpoSy9YL0w1RXdiUGozd0RxSXBZOTBmQlUza1pMQ3VFemFi?=
 =?utf-8?B?cERiYkJET2FQK1FlQmQ1S1RieWkzTDlzTkNqR0RqRlU4dENPYnJhZHFLemNy?=
 =?utf-8?B?aWxzazVTcjNrZFJsZXlWRC91RzFkdW1YSkNONmdMdjd5UGRQRE9PK0M5Q0VF?=
 =?utf-8?B?KzNQRjFEa2MybGRhYUg5c0RyaDFkS1lrbmM2L1hncmF4OHlyUEJNWnFENEpD?=
 =?utf-8?B?REVId0RjU1FVKzJXeWNpVHZhMURHdjgrODMvQ2MxcXlXcEFoRm1WVlBLTDN0?=
 =?utf-8?B?VGFaYld5R0VuUWJpbFhQMXhua2o1d0hQdjR6TmZGMitnUEsyanlnaVk5ajhZ?=
 =?utf-8?B?R0M1bjVEUlR0aGpQeHY2NndnVENVNXpIV0Z2MjErY1V3eHNxOG9TR281a0w5?=
 =?utf-8?B?YmNXaFR3Rk16V2t2czhvbDB6SVRteWpzaDhXcDFWa3J3VExiQm1zemppRURH?=
 =?utf-8?B?dHd1UzNyTFRrNGljMkxPaWxHU0ZIUjFZd2ROOW9UQS9pNWxFbGV2M2ROK3Za?=
 =?utf-8?B?ODhsYUZMWWJDLzlsYWRvbFhrOGhDdU1RSTIyNC90Ym1RbHhuUFdBRlFKSGtj?=
 =?utf-8?B?aVNvSXhVTEZsMWZGcFRXem90S2lMMGJTV2p1SmJnZ2xNRnljcm1ldlNMYkE0?=
 =?utf-8?B?VUE5TThKOGd4eXBydzJ6ZmY2MkVhRXlVNTFnWHc5WkxyRHY0OUlxUVRqTit0?=
 =?utf-8?B?VmliR3VOWjlQTW1vUzF6RmNvYmZ5QmVmaVFBb2FLaTkzR2tvQllKRXVLSmha?=
 =?utf-8?B?UnJqYVdHKzk1NmR1YkRuOUo4eEhMZnA0WEd4NytCMm1WTmhuQlMzVkhYMUxC?=
 =?utf-8?B?ZTBBcjlvUzdQRmFLOS9NYVpwdTBQYUZYN2pSNEtPcjBxa04xZGJlV0VFdEFN?=
 =?utf-8?B?cWpsSTVEZXZUOWhzcnVEaXdmUXVud2UrSWhmbUNxOFMxK0o1MXVFNjIvWEdr?=
 =?utf-8?B?cGRNRCtNMmg5bkxnT2U3ZmNPTFMxWGtPdmMvUEtzS1RVTk1oSWJjR3R5eWdP?=
 =?utf-8?B?Uk1KM1l4VEpicnRlcmdrRE91ckUvQXFGd3JxQlQ2VjN5RmtsQm5vZkFpdmV2?=
 =?utf-8?B?T25HUU94RGhPajFuRTZqVERIZGxhUHR6L3B2cTN1S1BHZkxNUnllY1BJb2pF?=
 =?utf-8?B?NnFCVnhCTzhRMGtMZ3dRZEhrZy8xazlLTXp4Zm5DUHBXVWJjakxBaGpsVGh5?=
 =?utf-8?B?L0YvNERHYmhvd05uTGpmWmNLS29neE93aC85N2laaUdWNmsreE5tOFJzOGNE?=
 =?utf-8?B?aVRBM1p6UG8xY1lZamdEWEk1WTVQVkJGSlZ4M3lyeVZtNkRXckxGaWJlK0l4?=
 =?utf-8?B?eUJCN1pmZzVxZzZza2pVMmtjcEVybkdoeWVuZjVFV3lDNld5cUVicjdoVTIr?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e1f991-52dc-423a-b7c6-08db03185229
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8127.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 23:18:39.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd07trYzuAJeccNgkcu32AjRX8kPOefBYmx/tSFK0IlRI8ZwSqZ1AzC6S1tMaCGgIN6aIleFcFJRiBHLkTtFC3/uP4PZROMJkj3ImobAf9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6460
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Mon, Jan 30, 2023 at 12:10:08PM -0800, Dan Williams wrote:
> > Gregory Price wrote:
> > [..]
> > > I found the same results.
> > > echo mem0 > /sys/bus/cxl/devices/region0/target0
> > > 
> > > Not sure if bug/missing feature, but after attaching a device to the
> > > target, you get no output when reading target0
> > > 
> > > ```
> > > [root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0
> > > 
> > > [root@fedora ~]#
> > 
> > Hmm, did you not get:
> > 
> > "-bash: echo: write error: Invalid argument"
> > 
> > ...at that step? Because targetX expects an endpoint decoder, not a
> > memdev.
> > 
> 
> ¯\_(ツ)_/¯ bug?
> 
> I went through the kernel code and thought it was looking for a memdev
> but i guess i was wrong
> 
> // ... snip ...
>     dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
>     if (!dev)
>       return -ENODEV;
> 
>     if (!is_endpoint_decoder(dev)) {
>       rc = -EINVAL;
>       goto out;
>     }
> // ... snip ...

Oh, yes, it is a bug. I fixed it up when I address this 0day report:

https://lore.kernel.org/linux-cxl/202301281313.kVrIreUj-lkp@intel.com/

...I posted another spin of that branch with that fixed up.
