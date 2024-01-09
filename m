Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7A3E460
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="GJpN5UeK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQVDOOMfaELg2GryXZTEop8+P+vApWjK8yLpG3OxTqag/793fioALzVXS6enkPRywRwX+H4IJcmoWb64RkI2BLEUcXi+jelv9pQgSvOsQBy8tNfmx1PU3Jbxz6kwCoeLbst5kWbY+nISStW8xFPywluot7K8dEtgFabaD6qzK1NfIsx0Fz5g0BzC02ERN0/cYOp+Waq7QEisWPorNHApPEfuaqLdDT9uTbUxH07VXSOVCSlsgWjAkw2g4Hp6Y0p37+ojK2daxq4pNUYTFsEydRhpNyQZtOkChMgQbTbYX4+R8HXyc3chz1AjTiDLCWewfu8FNdJYLmc5Yqpxbvu/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65qihb84fqHHhm46bwIFk0YD1fMk2hM4l52W6FRIEAg=;
 b=falVZGBbD8KKZC3wtov0O2STroVwOWwaOS/XHvsFBaq8LaPN7xHx7TVCZFQx/Lggef/YT9MP5XHsvxk53kg3/J+I4lV7C7z5DzihphJ3miWgTDr9SsJfgfLykmBSdcLpnvCqLnnuciRnZAUnl00qEGYVLNh0LqUiRu6/Q0RF2Mt7FOEq2tlCN5Q5G6MAJ9140T7wEXkI84EHtFAzmovttl1IHy1We8J7wsC/YEHzH+xEWL1pBaKNNNQKRPiSkjZbGoouExAquh9IXRjBiBCNh27TEiKzlilODVCUZJWq1zhNDDekzjPxUMdUuRLRadsCZByPOW/x6w9az53ZXT1SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65qihb84fqHHhm46bwIFk0YD1fMk2hM4l52W6FRIEAg=;
 b=GJpN5UeKZ1CqksWnecuOJUgzgwjs0hqsK/dqFBE2hycOnZ1cXikz0oZNF5OVLBt0iGJn050tRGJ9PsKSqyhHU/Hbi7zsFniJtxx351UsIqlGQD2w1ZxVDsFYAMrWcL1RanNrtxs9i1rPmVGVh8rDxsLcKUKjmdqU7JNKhxcubv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4668.namprd17.prod.outlook.com (2603:10b6:303:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 22:13:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:13:26 +0000
Date: Tue, 9 Jan 2024 17:13:21 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <ZZ3FAegN/ezu9Ghy@memverge.com>
References: <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
 <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
 <ZZydwBTS4NeSizzb@memverge.com>
 <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
 <ZZ2lNoTQ8hDHADTT@memverge.com>
 <CAAYibXjcVu-13h9jHpt2fZ3wmjz-_Dyj+WfUh0AEpid87GLriQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYibXjcVu-13h9jHpt2fZ3wmjz-_Dyj+WfUh0AEpid87GLriQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: 49649ec2-d783-4f23-49ca-08dc11603365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5hedSENaD7QctPwrw84AcZnlSYUL1PoSNX7y9fPN2RpUYVkfBcbaLu78iEHaoQx4a/Lw5blMQ7nvKUky2nD2BFmt/iCihWSdckH2vCU6NHxCi8gMHYgP0YxEYtbGpRBpVpJDJm4qbfUA0QXAUKrF1AhVA1F7cTbNGBOhaAIVlrr8qK9sMrRtJbKoC3k9BMBNPNw8CJGSo6+Gh/qDobllDat1JK6OkJ6jI88bxpG/arZinFfnGlWNefs53s6CExiGhPTcMI6MDBmQrqVyuDaNeBblKsBvHWalr2MirpuOk0/tOTZ0GCTco9r7WFrCjkUhaoXrAy+B1fHcDi85fyL1KJA6zbY73etCazlkYqa6bzcwRPuvg576OR0PENEDlby1XXzvXe4qTa+p4IEK+5NdgtDRX2NVWd5iteDeg+cqeb2SG5nNoBN1C8ZqnQwHpWGoj3a+n2oCBKV1IgG/XeiOzdqOmyFmqkyqwf4+IfR1DbmdZ3RDOzu0zFmnmK3VlNB4MyLPQdE/xff6xaFAdJ/5BvGyCYls6IFyb9emYpMCcwqv37cq/7OlAHT9Cif4jK15
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39850400004)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(5660300002)(4326008)(7416002)(83380400001)(6506007)(2616005)(53546011)(66946007)(6512007)(6666004)(6486002)(6916009)(66556008)(8676002)(66476007)(26005)(8936002)(44832011)(2906002)(36756003)(54906003)(316002)(38100700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXZBT2EwWFZnbGY3V09WZURjdDNueGJMRi9uYWxMb0tNdXQrZEdib1JnR0hz?=
 =?utf-8?B?YitqRWdlbGpFNThjZmFDRVZCRDVLTGsxb0NtUWFJckhJbTRScWx1Kzc1ODli?=
 =?utf-8?B?SmhTWXZpbEJNMC8zeGJuUFJKL0FGMko2Z2RnYWx1bXdJcHJTaWhIWllRWW52?=
 =?utf-8?B?dmp0M29YSkxnVVBWeHRHSmcramxFTDVBMU9xTE5LNTU4OUI0aGhFbDhPVDN0?=
 =?utf-8?B?QUdPcHllbmJqVjhNMnl2NGhhcmlmVnMzTHplQmxmTWtjVk0rR1o0cVBXZDhM?=
 =?utf-8?B?Y0ZwL1hJcjdMTTZFeGxBMmlydDdLTFY2bkw4ZmdsVnVvaVFqUVdPOEQ2YnE1?=
 =?utf-8?B?aGhZQUVsNjJFaWpmVVJERTMvWDNqTURIZjkrMXZOTFlNZEhJeHZmWGVRUDdn?=
 =?utf-8?B?K2JTNVcxMEZXQ0JFNnpMNWN6emNNYi9UNzhTN0lPNXJXKzlBbjI0MUZPc1dz?=
 =?utf-8?B?MDVTTlV6MWtSRmRMaVFxM1B5TDBURUZiR3lpRmV1ckQ1WFFvN1RRSGFLb1pu?=
 =?utf-8?B?YnVvcTFXVXNHdnRvZU9jT1B3TEE1ajIyNWRFSW1ZK1dMbnIxRHRzeGpXbS83?=
 =?utf-8?B?dnRtT3Z0dTFWVGdFVFJUdGV6TGVyQTQwajl0QTNPZzBnSEROUHRFTmdzd3I1?=
 =?utf-8?B?OWgwcHZKMlF0dEJnQWducXRSUTM4ZG5ES1pGR3ZLQVBHdXJxNUNvdk5vNE42?=
 =?utf-8?B?Q3VxWDRWaEhiQkpoTU9PTHpKS1ExVnduUVloYWxPMzVCUmxsNE5PTGlqQndF?=
 =?utf-8?B?LzdVQ2E2VWhTUEwxYTRyYjh5bmtkSE4xb3pzUE9yZUZOM2JaenVhcldhKzdh?=
 =?utf-8?B?ekp5OHlJcUdYN3FDUFU2aVI4RDkyazQwOGoxb3B3RWxVcHdlT2pEQ0ZrQjU0?=
 =?utf-8?B?ZndaZ1E3bW9mOTFDT1A0RUN1eHYzZ0xWZHhyVzh6bUMvZ3dPT3dlUHYwWUZC?=
 =?utf-8?B?bUpTQWFyd3BsZ1EwYyt1OVB6SENXRFhKZndOM0lhalUvZTJpRnEwdzdXVFRk?=
 =?utf-8?B?eWJyTlVYRkxmeDJDQnhqVTg1MFNrcmpHeStYWjkyNzcvOEhpM1ozUmVuNUZP?=
 =?utf-8?B?UHpHUDFqZFJpQS9RY2xjeEQxTlA4ZHI4R2pGWCtzQUNadGdpSU5qakpTbWFP?=
 =?utf-8?B?WmJFM1FkRGh0TTlyWEZyZ3dSMU03YnEwYTlvRWtkakZqR1E3NUozdHR4YzJD?=
 =?utf-8?B?UUc0bmthcDdoM01na09KbFExWkRQcHl2clF1RjRxTjlrWGdkWG0xRnlLR3hX?=
 =?utf-8?B?MUZJbGVMMlo5cGdlYXVpdmQ4YVJGZzNNcDhmWWtucTJKZ1U4aXZOMTlscUVs?=
 =?utf-8?B?c1VDOXFsY293NGpJdklpU2wrRTZ5YWVBNkJMSEdJbWhLZy9lUVhmWVJJU1E4?=
 =?utf-8?B?cnYzb0JES0FpS3dFcTE2djd6c282QWRJcThjWlduOHR4RUNUV2ZoUzVvdWVN?=
 =?utf-8?B?UHVyUjFsNzRvbUxYVDZqMENtRHRzaGQvUEpaS1k2Rk9HelVrcGM4NHpTMVJw?=
 =?utf-8?B?eXpGRGt1N0NwcDVwUEZjWjdmVGdkOWM5eFhOcCtKTGxwNWc2N0tOOEc1SjRl?=
 =?utf-8?B?LzZ3L2ltRXhwZDJsVUQ3d2dBSGp1Nm1ub2VMb1ExZlVRaDRodWFubUF6RmJp?=
 =?utf-8?B?bWxqa1A1TXJvVTR6dHVEZkZJbWYvTlBqZEllbXhnM3RueUthRGlJcFJET3BW?=
 =?utf-8?B?TUtBR1Y4Y2JIWVlMek5SMmVXQkZ0eUxkWjJYZTlNcTRsVVFzOWlQcWc3dVAz?=
 =?utf-8?B?YkpWMU52VXhxaWVqSE1tZWdDckFxVDJyd0xzQzhERGJMRWJyS1AzOGpwdjhX?=
 =?utf-8?B?YURWbm5aMzRmckwzU3NLdWtYZEg3NkxkYUNlUTZOTXA0dUUvazV0R0VmLzFx?=
 =?utf-8?B?TUNjb3FlaXBkQlFhRjJlWVd1MEs4akJkUEl6YVJMZXFvOHdMdURWdFRGUFFV?=
 =?utf-8?B?Q3hNVW9lZTdmZEpHOHJvVjl2NXVrdFZlR1Y3dHF6OG9sTWVHcnVkNmh0ZFFX?=
 =?utf-8?B?WER5NnNNUm9wM3BqMXNvejF1UHhHZGJpMHEzdVJXY0VNNXU0UXQvVHpXeXpi?=
 =?utf-8?B?Y1o2cGR5ZzBIbjBWaU5VdElsOEp3b2kxM3k1YmMvc2dzMy9LbitpSktpMmJE?=
 =?utf-8?B?QzZyeVZwdUFUc0h2TElCc0xJdFlIQ1hiSHZ6enFTZlhsdWJ1UVIxUVFqdjZY?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49649ec2-d783-4f23-49ca-08dc11603365
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 22:13:25.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsJ/ov4EaG9txgAIAHRzPuz+rWkxJXtBx2GnMfwMwuH6VvK5C5PsuN0QJL56G9BzBTXKX3TlOxh33ZOa7TxN3RmBEMzadCNKrj+ts27Myuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4668

On Tue, Jan 09, 2024 at 01:27:28PM -0800, Hao Xiang wrote:
> On Tue, Jan 9, 2024 at 11:58 AM Gregory Price
> <gregory.price@memverge.com> wrote:
> >
> > If you drop this line:
> >
> > -numa node,memdev=vmem0,nodeid=1
> 
> We tried this as well and it works after going through the cxlcli
> process and created the devdax device. The problem is that without the
> "nodeid=1" configuration, we cannot connect with the explicit per numa
> node latency/bandwidth configuration "-numa hmat-lb". I glanced at the
> code in hw/numa.c, parse_numa_hmat_lb() looks like the one passing the
> lb information to VM's hmat.
>

Yeah, this is what Jonathan was saying - right now there isn't a good
way (in QEMU) to pass the hmat/cdat stuff down through the device.
Needs to be plumbed out.

In the meantime: You should just straight up drop the cxl device from
your QEMU config.  It doesn't actually get you anything.

> From what I understand so far, the guest kernel will dynamically
> create a numa node after a cxl devdax device is created. That means we
> don't know the numa node until after VM boot. 2. QEMU can only
> statically parse the lb information to the VM at boot time. How do we
> connect these two things?

during boot, the kernel discovers all the memory regions exposed to
bios. In this qemu configuration you have defined:

region 0: CPU + DRAM node
region 1: DRAM only node
region 2: CXL Fixed Memory Window (the last line of the cxl stuff)

The kernel reads this information on boot and reserves 1 numa node for
each of these regions.

The kernel then automatically brings up regions 0 and 1 in nodes 0 and 1
respectively.

Node2 sits dormant until you go through the cxl-cli startup sequence.


What you're asking for is for the QEMU team to plumb hmat/cdat
information down through the type3 device.  I *think* that is presently
possible with a custom CDAT file - but Jonathan probably has more
details on that.  You'll have to go digging for answers on that one.


Now - even if you did that - the current state of the cxl-type3 device
is *not what you want* because your memory accesses will be routed
through the read/write functions in the emulated device.

What Jonathan and I discussed on the other thread is how you might go
about slimming this down to allow pass-through of the memory without the
need for all the fluff.  This is a non-trivial refactor of the existing
device, so i would not expect that any time soon.

At the end of the day, quickest way to get-there-from-here is to just
drop the cxl related lines from your QEMU config, and keep everything
else.

> 
> Assuming that the same issue applies to a physical server with CXL.
> Were you able to see a host kernel getting the correct lb information
> for a CXL devdax device?
> 

Yes, if you bring up a CXL device via cxl-cli on real hardware, the
subsequent numa node ends up in the "lower tier" of the memory-tiering
infrastructure.

~Gregory
