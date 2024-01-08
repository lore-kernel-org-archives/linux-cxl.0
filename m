Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F453E3A
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="OvJKL8IV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj+NgIPUzZb1LDyo37IRYV2DKpUTEPPaTLlYA34scRQWEO7dgyIi225JRk3wR209ubgrzvKtMU1LB8ht4ersiVzJb/3yeZ7MAZd5wQI/qe5Q8rQMagxjU0vpt5ELswftA55ADDsHcjPQbSr/oJtGhUD6FYcEsDLsBMRY5nSH9n+akZCCmiG57RaT73wKEDEFJrbBGBGQLWJ0cRHLj/XlAc5TFE/ukF+H7WSjcvOD9FE8dnggyWrFSZbjYmYY0AxbNmuGbPd8ykAnicjrz0+mgfJqetxge9dpfpAJR5eqDb2MWBYpSFefP6vQPfiV0hPA0Z/CMMtFsOHUcVnE3dKL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmO3T6KpGRVSYLAjdeeThnV8Prm8IFZa76lhZ0uBWDw=;
 b=SMqqMbt7L+w80eCPWNCyTIuim1Krm+M6rAvl5slkTdZ3VcdfoZd2x2ZiLs92MxiwmbM0eUElMWLZ4gzVqjUnj7qgCsvazbqVNMbtAeDTnKF8ltsF9kRlRPHkQljI9HjOekESCOhivyq+/oZVbuZzEU3y5zkaXPia9RJ674dKgDwZ1yKwuGp2it5axUQJjI3gzvaSeUY8QrIHwcQI9FCxC03XgeldfUqi/Bcpl4bGzh/PQonSo0bVhpeEz3oWa5VPU1S46ZRSEXGsv9QqRlv+zlNpgZvEhdB9h1D/nFS5+aT3pzMiyKIN0+odGzbV/fow7TbI18apY39YDM6rrO75Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmO3T6KpGRVSYLAjdeeThnV8Prm8IFZa76lhZ0uBWDw=;
 b=OvJKL8IVzegbX/woIXLdlKcgEZfRvQlNxuBwBIh3D1ua4ZK0jBY2OJdrYmSeo7lkAwX3XK0NJrBduCdHr6t6frVbsTJbEUj2q29jj2RXBx2K6G2dGWyt5HwF9mzgwWwENJOzy9OB9mA2Kqp1cw/M/6PqOcVu/0sWeT37iNM89Xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN2PR17MB3888.namprd17.prod.outlook.com (2603:10b6:208:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 17:15:15 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:15:15 +0000
Date: Mon, 8 Jan 2024 12:15:06 -0500
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
Message-ID: <ZZwtmiucNXxmrZ7S@memverge.com>
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN2PR17MB3888:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ce1e4a-f2b9-4a53-6546-08dc106d6138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nxzPzJ7dnv/Jxo6g3qeI5p6lr3f7Tx8KzRUh4I74AerhA/dzCA6vHg/1jDz9nQaliOb6sSTQ3Vsjs3bIjOfNlJ8TU+YbsfZ2aS6R1xgC35t8L50gAzYVbu5vr83afN3viGJYsTzASbFNMKNGUDQDS5a+DHaBRJQpuD9IkZdoYdABgP3WdhPJHIW2VchoeBDHTqKEAkvO7Fz2XA4r2HMzItraL6Nf2YJ97pbs6+ib42dVJc+korAM0yaMOrmozn7ie4f5eUZpccokr2elf3rxcV54PB2N8OnzusdVWN8anoYGn7YWz7kQUeAqBkVkAvLH2+Pv5H6tF3sn5Gh9wm3uNFUBUPyKAHIOpTWtn3KNPhYA7488KOeDml5tuispWA8rFPG5l0t+FRg8Lx+ZXGW7V0Nv8cBUEOPY2iB2bX1gyG9PWfqO5WRHPHFVXNjYwsWrn36JVy+EBL53w2ILiEv6wK5BWjnTD7ez+tJXJzLjZjPOMwdomQk0vXpb6Xs/gNtAHuf8pcGMkpo6fk8vuInXxAzmlUnwnbVqv+bEF+nNs0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39840400004)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(53546011)(6512007)(6666004)(6506007)(478600001)(6486002)(966005)(38100700002)(86362001)(36756003)(5660300002)(7416002)(2906002)(41300700001)(83380400001)(66476007)(54906003)(66946007)(66556008)(316002)(6916009)(4326008)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enlqSjcrMFVyejdLM0RuaFpjYjNxSktrTklyMTFQV1UrbU9PTU50QXZ3dmJM?=
 =?utf-8?B?YkVITEZoaHNkd1poZEFBTXFIeXRuam9JcDY1cWhpeUR2ZjNadGdkS1JRZGFh?=
 =?utf-8?B?Tzl5V0VtanlWZ1grd3N6enhzd2lpMG41Ui9UNU1mUU95dU53RlV6ekpRUjZ1?=
 =?utf-8?B?bTdlLzF1VExkVE42eHh0SnVNeGlpcVJ5MmxzSThNeXZPNGM1SnJUVXhCU0pT?=
 =?utf-8?B?SWpjelIwcnZUZmwzSU1rdWRiZWZFNHBscnc5dXByQUJHQmlUWDBrcXlBeVhF?=
 =?utf-8?B?TVJIaTMwaWRoNDk1Z0JjVVZXQXdxcHFkbVJ3R0svWGVPU0dKRGFUU0JaeXZX?=
 =?utf-8?B?SDltOWRmNk5GNk1UbXdQQ3ZRemJEbmtZaWdrdU45SHA5QWFjMWNhSy9nanl6?=
 =?utf-8?B?ZER2OUVMQW9IKzh2b1JESGxXTGpWSTExRTZNTStRYVJ6dnVRbHAwNUtPR1NZ?=
 =?utf-8?B?dkZCMXFYSC9FN3dqTHgxZTlwWGFwSUUxT2Y5SXpzdUs4THJQYk5VWXJKSGxI?=
 =?utf-8?B?bU81MXlLRHpuQ01vSzg1OWZmSisrdW4zQlB6WmwwdWJXTkZ4ZDZUVXpRTmEx?=
 =?utf-8?B?UDN4VURvMmtvQUt6ajZLelA3V01CNFpyRDBRaUlYczhKcUJUMUgvUGVrNFQx?=
 =?utf-8?B?ckdVTld5RTI5L2FUTTByQlUwTlZyUmkwT3ZXcVpXb1RjOHBuUXBXZDRzbmJD?=
 =?utf-8?B?b2x1aldmWGJLSW5yNEI5enAvN2RuMGR0eVZzWC94WXkzamVDaDhnWVpFYkJ2?=
 =?utf-8?B?V3pDNXd5K3JmWUpzYVNlSXI4RnJRMkwvbU5tekpSTmE0dmRwaFErbUQ3QUNu?=
 =?utf-8?B?dk1CbXc3WXFqNHNsck5SRUdrb2VlMEVKOVhXLy9haUFBNXdFbjNmQUN3M2J0?=
 =?utf-8?B?aUxxb29XaDZ5R0N1eWRwRHRQVDhCckRYelcxWjZtSmFxUWtRZUpleFRCUG04?=
 =?utf-8?B?VkdYRFl3U1pIRHVMR2JJdTFhREJSNFZxZkowaUZoVW5nMCtVbXA5cFJTK1Az?=
 =?utf-8?B?QTBFbkpWc01ieS9QSW1hazV2YnZxaWlvQTFVTW9jbnhtYjN5bTlacjB3NTZo?=
 =?utf-8?B?SVV6ZUJ5clZpVmYxTjBuRHpkbWJkRlFRTWVIRm41Uk5xMThVamFHd3dnek9N?=
 =?utf-8?B?dWxjYWh1aGMya3F4ZFBkWmg5Vk9ORFgvTTlZcEU1VHpHTS9vUG9HTWVUS3VE?=
 =?utf-8?B?Z1kzZW4zWXp2dm5PQ25UWGp3ak9JOUVzVmErU3ZPTjdxVi92a1pQbHdDYlNU?=
 =?utf-8?B?VHVma0xlYnpPVi9iRUVVZUhQSkg0MXlnTWdUSjJQc0puNGZVZkpBQVZVUG1j?=
 =?utf-8?B?dTlOdW9nakVQb2VVNEg0d2hvWXQ1Q2FJZDVBeUlVWU80YmpFQkYzRDg0SGlC?=
 =?utf-8?B?NURURjBDTUlUMkpNMFVDWjlZYzl6N0NEMGMwMlRFbGtldVhMS2RsRmFXVklo?=
 =?utf-8?B?cWh4cWRxblh0L0ZqOEMxR3ljc01xY1hsZHJmUUhoSlFrcEpEOEVwSkx2YUJ4?=
 =?utf-8?B?aEJpQ3o0VTgrWmY0TUcrQjdXN05qQnZwMVZlMmlZbHVweDk5ZGpiM1BzUDM1?=
 =?utf-8?B?VSswYi9oeXlSNjRBRHR3R1QwT1BUbDdvMmxiaERNQk90bU94ekVsQTFrSlZk?=
 =?utf-8?B?RmZxV3VGYkE1OVltU3JNUExyK2tzTDV0RFdlMDFVYjVGWTBMejBxUXd6MEhF?=
 =?utf-8?B?UWUwS0xQWk1HeUREOFlCSGhwY1kvVmZ0THhlT2ZPT28zSFRFSXk0cVI2R0J3?=
 =?utf-8?B?TCtwQnU2bVpBUWJZeVBSdVh1K1ZyRDlmQ2NjUWxHSjRkMlJuRDlsN0dSdS90?=
 =?utf-8?B?L29nUlRycmZkVUhpYXg4ZDQwVG5teXVRR205bCtrVWJsdUp5bHRhZ1BXbGRY?=
 =?utf-8?B?Z0hjM1FuY0Z1UXduZ0M5M0pKa3NOcE1qNERIT1VaZXZnUCs0dnBHY1N4eGli?=
 =?utf-8?B?bVhkVklFMnZKcDdsa1Zsd092dkdBSjRoYjE2Y1BkekFUVCtDekVFZnRYY0sy?=
 =?utf-8?B?NEk5eUdSUXZxaHI1d2V0ZkFjdEpPWG8reEI1VVhhNG1Wck13aTBvYktwSkti?=
 =?utf-8?B?RXIraGl1biswT25sTlBoNTlpa1FENjZqYzloQlZ6V1dWUzJnMXRwcHhYTEZS?=
 =?utf-8?B?R2R0TzVMZEswR09wZjltUUM5ek05eEhEdElOdm0vRVdGdHRFNHduSVRtMEd1?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ce1e4a-f2b9-4a53-6546-08dc106d6138
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:15:15.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcI4y/9lUDcdPkWWnXZ8MHSHJn3EJz1rI02xdBPFadH1ogzlH0twF9k34QQcE4/0vT9R/gb5h6GUxbO2gpvqF7rTGkyJ5Ii8uG0/+i2xv3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3888

On Fri, Jan 05, 2024 at 09:59:19PM -0800, Hao Xiang wrote:
> On Wed, Jan 3, 2024 at 1:56 PM Gregory Price <gregory.price@memverge.com> wrote:
> >
> > For a variety of performance reasons, this will not work the way you
> > want it to.  You are essentially telling QEMU to map the vmem0 into a
> > virtual cxl device, and now any memory accesses to that memory region
> > will end up going through the cxl-type3 device logic - which is an IO
> > path from the perspective of QEMU.
> 
> I didn't understand exactly how the virtual cxl-type3 device works. I
> thought it would go with the same "guest virtual address ->  guest
> physical address -> host physical address" translation totally done by
> CPU. But if it is going through an emulation path handled by virtual
> cxl-type3, I agree the performance would be bad. Do you know why
> accessing memory on a virtual cxl-type3 device can't go with the
> nested page table translation?
>

Because a byte-access on CXL memory can have checks on it that must be
emulated by the virtual device, and because there are caching
implications that have to be emulated as well.

The cxl device you are using is an emulated CXL device - not a
virtualization interface.  Nuanced difference:  the emulated device has
to emulate *everything* that CXL device does.

What you want is passthrough / managed access to a real device -
virtualization.  This is not the way to accomplish that.  A better way
to accomplish that is to simply pass the memory through as a static numa
node as I described.

> 
> When we had a discussion with Intel, they told us to not use the KVM
> option in QEMU while using virtual cxl type3 device. That's probably
> related to the issue you described here? We enabled KVM though but
> haven't seen the crash yet.
>

The crash really only happens, IIRC, if code ends up hosted in that
memory.  I forget the exact scenario, but the working theory is it has
to do with the way instruction caches are managed with KVM and this
device.

> >
> > You're better off just using the `host-nodes` field of host-memory
> > and passing bandwidth/latency attributes though via `-numa hmat-lb`
> 
> We tried this but it doesn't work from end to end right now. I
> described the issue in another fork of this thread.
>
> >
> > In that scenario, the guest software doesn't even need to know CXL
> > exists at all, it can just read the attributes of the numa node
> > that QEMU created for it.
> 
> We thought about this before. But the current kernel implementation
> requires a devdax device to be probed and recognized as a slow tier
> (by reading the memory attributes). I don't think this can be done via
> the path you described. Have you tried this before?
>

Right, because the memory tiering component lumps the nodes together.

Better idea:  Fix the memory tiering component

I cc'd you on another patch line that is discussing something relevant
to this.

https://lore.kernel.org/linux-mm/87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com/T/#m32d58f8cc607aec942995994a41b17ff711519c8

The point is: There's no need for this to be a dax device at all, there
is no need for the guest to even know what is providing the memory, or
for the guest to have any management access to the memory.  It just
wants the memory and the ability to tier it.

So we should fix the memory tiering component to work with this
workflow.

~Gregory
