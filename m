Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FD28E8
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="UXTXjZNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUFSoB+0Gl4ESCGGXO0QnFQmuZUtZVtg8tbUAnXF0KueGHRSRZbcnLMUliC1Tc3UL4DaTUCN1dpqIHpG1qIoWVBaAiM3pnph8jtijM3LuIPkhp7abExj1v2/72zhMF5M7bKHHH6MqpmMWZ8xEbEF7JeT6fXzHhA3yMyavNL9pCzGZu7+2Exr8tqJ+c+aipHt9hgjo8Qoei04w+QY97c6SEoV2px918+eawC5KKWmJDzYW/ztsPYcPHHuCgujGSOX0g0MzsUA+EOhsjk0/NM5IwMZjaL5xsx3TP2VLQ3mofEOwLDO9eFKo5RgDU0wx0NTbBVl5JYNKRxnsarSr8TryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XvNA++Exg82aNSgJpEYnYac4uO5mIXMfdb5zyjA7uI=;
 b=QB8r9wZnmyEsvA96tTBN/rBcnisrDMFjMChlZnU8oY95dPogJEpRXVprbem7LbtslrpE/rn2jqSn296JhCEqm/DcQJvWuoZvpQoOSa5buFuJeLn75xb4uUi8UI9QSe0mPaG2cV2cX2gofRXTPbAko6VLkAemOvKl/4zw9iJFVtAcH9pLU2gjv6mOTMviZJfNfVXa1qNUxvCRCrAtKIGJWmK6dxwMYbkA+aj5xsVS0YSgrIwAFbKfB4ymxDIvQ7LkVP2nHNbv1R/qKomwD4+Sprjg55hiFXy+nzRx7DT7i3ZEoKKdiS084CJELgGcBsvSLi3TSL9qI4+N42or6YOw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XvNA++Exg82aNSgJpEYnYac4uO5mIXMfdb5zyjA7uI=;
 b=UXTXjZNencHmcQOZkAvvNzspO4m51LRMVGW2pp7IcLn1u+slH5VE06//C5icXYKRszKi8hnkHRFwxmc4w12ejz+K+EU4GO2E+GPCaocuRPASF881p9KyOIVaNFe0dcPONWmLA3x5NiJb4i9bGNLBhY2wB0oXj0e977wcE3pR1Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4295.namprd17.prod.outlook.com (2603:10b6:510:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 01:13:40 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:13:40 +0000
Date: Mon, 8 Jan 2024 20:13:36 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and
 its arg 'cxlram'
Message-ID: <ZZydwBTS4NeSizzb@memverge.com>
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
 <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 104dd9e1-ae68-4a30-d0da-08dc10b036cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZiLj0Pn0cvhNMw4eID5U0n9osnrXh6wkiDaR36CUhgkCH3S9DTk0oiJPO8PKzY0+iTutfEMc5WsiS7wSHy4s6NpA73oZnjj2mhPzbDOAcrQKl/wft+9B+ApYqVwcYOUDQgKoWXBV7W4fa9kIS15RF+PwYUaVpICbKkPT9O5VO670M6W+gqDLCHi+5ZbWsEoBGg97qlh4OwrLHf31jWgV02ipRFy5cD6HR8Vuy9mPP9uLF6q0YJqn3NgbuX3htfVpn8bphyP52ukIxbtFvwtbCg0PwhTgoEFuHfogfSoCNRd8uWRjSqi0nrKZ7L+0pFtBFp9gmTLKnfmvAOP3/CXXBnlVFpac67V6ZWZhgQ09YxhmbmWD31lgxdYoEqz0geTdVgEZye9ORk0JpRclSZHNc3aoTmqe4yU0xxPtmQDMeQqOCuBNvCnhHsLs3ZwKV1iIk6wL/iYxjt0mb0e4qhj316YRkQ9DvZNwPfX0MkndDtEoSGNbnDSkdNbaSq6/aMzWdaMJQ4M+e6sz39f4vKpkFFmEzLb6DwKcC4QM4Ap0QXaJzHmn9JIY2eZV+XHyBZkL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(38100700002)(41300700001)(2906002)(6916009)(5660300002)(54906003)(36756003)(6486002)(44832011)(53546011)(86362001)(6512007)(6666004)(6506007)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(4326008)(83380400001)(26005)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW5IcDNEVTBwcEVpVE9HVVhiOHZnOXEyWjhva2NvSVg3R3cwbFFYOEo3NTNi?=
 =?utf-8?B?L2FGV1JMeFptd3A5RzBBOXM1S3RzSmN3NzA1QnRBdk5SMlZlc3VTeEJabmZX?=
 =?utf-8?B?WUd3NW5Ld2JGRzBjTHo3NHcxLzk3Z3RSQWV4NnBNS1ZmQnp0TDdjQXExa1JE?=
 =?utf-8?B?L3FUSVBMcCsvOTIxUnhGZ21NdDhTZGJGQk5Ma3Y2YnM4cGdMQWExQjJBSSti?=
 =?utf-8?B?enV4TmZDa09zakQwc2psSklHMzdUNlRqWS9vMHNwblRibkF5cmFKS01MWlZK?=
 =?utf-8?B?ZUtBajc2ODJ2WVJUS0hoU3g2eDJ1cDFxL25EWXBSclkxMzducFZxSnExazBM?=
 =?utf-8?B?bUtTNXBRUXZCcDh1MWZCdXlyb1hrRW1BZDR2Tm5mMjBZaDlnUEd5cDRwWEZu?=
 =?utf-8?B?V0t5YXprSG5UekRtRkZtaFR0NG8vWVJORUdCZlV3emVKWjlaODNySWVzZjk1?=
 =?utf-8?B?NGVvZXRidFRBQ2NxbDRGQ2ZtQWZPRmhQakp0Z0ZCSlJtYVgyTkI4MjV5Y09m?=
 =?utf-8?B?amxoc2NlTVMyUDRDQXN4TW9HSmZPcXc0ZDRPWm1BTHBJYWpNVGRMSnZ6b3RC?=
 =?utf-8?B?ZFdBcWY0V2drZWhoRDNFOW00SmlrWWpWNlBvcEZXaVlJb1ZmeGNTL2RmT1RY?=
 =?utf-8?B?dzlzTHdIUnhzeGlQaTlHQlFaUlViSnRNa0pWUmhDNVZFR0trM2RJQWxheHU3?=
 =?utf-8?B?N3NTbWNHSW1XZlpPcmtOTkk4WlBucERPby9IOUdNZzJFS21nM0FpazQ2aWxE?=
 =?utf-8?B?SjNMeVdBZmM4T2Urd0tqWVptM1JDUVJFN25PNzVGOXZ2azYrakdROFlQeDNv?=
 =?utf-8?B?VGN6ZkZYWm9MM1Npa05lYis5Nm5FMWZJMGh2cVdvQUNyT1VBUjA3SjZiSnpX?=
 =?utf-8?B?NERGQU1ydk00WEQxUDY3MWd4aHZRdStheVJTTGI2VzFERHViT01NQ0lwb2t1?=
 =?utf-8?B?OCtMdmwyN3Ztc3NraDZsYmdGL1oxeDZTOWlOYUUxMUhNOXlja2RCc2wydzJL?=
 =?utf-8?B?M0dpVWY2U3Y1UWloQ1dNZndDbEFmekg1ZnpwdWdQSWlIZjZZWjN1RUpnZy9V?=
 =?utf-8?B?MVRSM1Q4dHpTUng2dVJ2eUVTMzFReTlEcWlJSVBSZXBrK3orbTRISkNybjFK?=
 =?utf-8?B?cXROeXV1RUp3aVpDSWJvMVMyN1B5VDhiVU45QWJoL3pqKzRIUjEvaGRWaGxK?=
 =?utf-8?B?Q012dGlMV1RKc29vUzRSaE50b1U2SUl0LzIrQmI3Wk9ERlVmbXlmRDNobTZr?=
 =?utf-8?B?OG1zZTcrcHByN0ZleU0vVUNlYUVrY1hsM1A4VmdJYWZ0anhSd1JVR2FETHVH?=
 =?utf-8?B?QTdDa0w4cHl4VFowWlRtNkNkWEkzSkE2L055NHNsY2RBNHRwdUZaQlFiT3FL?=
 =?utf-8?B?VDZ3OG0zZXljdjRNVmZuV2h3N043ZTlWMlQweHl2R0tTa0JBd0dsSTlhQzlE?=
 =?utf-8?B?UlJvRGM3d3g0VUQ3UW43SnpOZjJJbmQ3aXNUSGY5alZlM01YYmRPN3loQk9R?=
 =?utf-8?B?ZnhZTjJYcGRVME9ySG5NTEtnYS9xK3QyaTJVRCtMU2swOUtvbzhIRWlWZXJr?=
 =?utf-8?B?QlVWY1JudXpMUTZGaGY3YUIxYitCMXgyMFQydURyZUxheFhkREtkYW56b1N6?=
 =?utf-8?B?TmQwbHhMMnlMWHh2ZzVnSnlkeC9seGlNcmxJSVJMOUVZOW5KN0ZadVNnYnhV?=
 =?utf-8?B?ckZIYkNWU3hRa0Yrd2M5QTlpS1lqWENKR1VWd3dwaEtNYUtaTkdjZzcza0dQ?=
 =?utf-8?B?R1B6TFVlL0p5UjM4aHJITENzTndpVTluNlNYZ2FtcUE2V1VjcW1kZDVEREI0?=
 =?utf-8?B?Y0lOc2VQRjJTcUdMTWZGbTNSazZ3Ry9xMXlId3MzbzRIdUgxTHpobGs3YzBQ?=
 =?utf-8?B?dldqM2tqUkg2eVlkL1ZoT2l2V0xaSytmYy9FWGpTY3ZoT3gvamVoWWxJMnE1?=
 =?utf-8?B?eGJkTjdGeEorUTJtNTU5RjFBUUdFY05wdTlBSVNsUFBDUkhSWkRDRkxkU1pE?=
 =?utf-8?B?MEw3NHFtTXZNOWo3K3YrWTZpSGpwbVorNUhXV1hZa29mMWc5dXlwOUF0SlQr?=
 =?utf-8?B?Z242VDEvWDJSN0NXMTR1Y1pkSjFFNWFFcS8zOHJJa21vaE80RXYrSHllaUVs?=
 =?utf-8?B?OFdKZHd5U1ZMT1ZBd1dmRk03SGVjSWtKenFrNGdlMmJTdTBVQVFXRjBtQUpI?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104dd9e1-ae68-4a30-d0da-08dc10b036cc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 01:13:40.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D84gffIxupWVDZqeqOPKK6ZnOp6dDK/ST0Ew8Avwbh1JSBLtra4QkdlkLqdvMteiSCHbL+TYRuixJ6Ve8ebmpujVQajcWYb53CwkqDOlQBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4295

On Mon, Jan 08, 2024 at 05:05:38PM -0800, Hao Xiang wrote:
> On Mon, Jan 8, 2024 at 2:47 PM Hao Xiang <hao.xiang@bytedance.com> wrote:
> >
> > On Mon, Jan 8, 2024 at 9:15 AM Gregory Price <gregory.price@memverge.com> wrote:
> > >
> > > On Fri, Jan 05, 2024 at 09:59:19PM -0800, Hao Xiang wrote:
> > > > On Wed, Jan 3, 2024 at 1:56 PM Gregory Price <gregory.price@memverge.com> wrote:
> > > > >
> > > > > For a variety of performance reasons, this will not work the way you
> > > > > want it to.  You are essentially telling QEMU to map the vmem0 into a
> > > > > virtual cxl device, and now any memory accesses to that memory region
> > > > > will end up going through the cxl-type3 device logic - which is an IO
> > > > > path from the perspective of QEMU.
> > > >
> > > > I didn't understand exactly how the virtual cxl-type3 device works. I
> > > > thought it would go with the same "guest virtual address ->  guest
> > > > physical address -> host physical address" translation totally done by
> > > > CPU. But if it is going through an emulation path handled by virtual
> > > > cxl-type3, I agree the performance would be bad. Do you know why
> > > > accessing memory on a virtual cxl-type3 device can't go with the
> > > > nested page table translation?
> > > >
> > >
> > > Because a byte-access on CXL memory can have checks on it that must be
> > > emulated by the virtual device, and because there are caching
> > > implications that have to be emulated as well.
> >
> > Interesting. Now that I see the cxl_type3_read/cxl_type3_write. If the
> > CXL memory data path goes through them, the performance would be
> > pretty problematic. We have actually run Intel's Memory Latency
> > Checker benchmark from inside a guest VM with both system-DRAM and
> > virtual CXL-type3 configured. The idle latency on the virtual CXL
> > memory is 2X of system DRAM, which is on-par with the benchmark
> > running from a physical host. I need to debug this more to understand
> > why the latency is actually much better than I would expect now.
> 
> So we double checked on benchmark testing. What we see is that running
> Intel Memory Latency Checker from a guest VM with virtual CXL memory
> VS from a physical host with CXL1.1 memory expander has the same
> latency.
> 
> From guest VM: local socket system-DRAM latency is 117.0ns, local
> socket CXL-DRAM latency is 269.4ns
> From physical host: local socket system-DRAM latency is 113.6ns ,
> local socket CXL-DRAM latency is 267.5ns
> 
> I also set debugger breakpoints on cxl_type3_read/cxl_type3_write
> while running the benchmark testing but those two functions are not
> ever hit. We used the virtual CXL configuration while launching QEMU
> but the CXL memory is present as a separate NUMA node and we are not
> creating devdax devices. Does that make any difference?
> 

Could you possibly share your full QEMU configuration and what OS/kernel
you are running inside the guest?

The only thing I'm surprised by is that the numa node appears without
requiring the driver to generate the NUMA node.  It's possible I missed
a QEMU update that allows this.

~Gregory
