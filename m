Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B23D565
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="trcNJkdh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzkTdUcrjqFsmL4s7XQT98hclT/9lZzYReEBtygbQBIHLinv14UuAAKUTx1BFaUCk9yZ+B95r5VBidqlGZm4QKZafOpguaHYlTKABBo9eRJpoup6Wux2jEKtiBcnUikMQCAeFnZE8LFVFXk+sNT7fC5sG9XRkKgUmT8bL/oUoZLIei0gVs2Cx6Tj0z7zSLEVUPexWJElDF8Ei5JXy3lHm0Bn10wJ3UmM7PjAsI2ePnvI3Ucl0VRBEvdDmo922RIxVYf09NyR5fvhwCmcwqBuJ4pKNnFfAWbu6pphGgxpoIPCXn5muVR3AVW5NwZT7b7qyIDVCYdWl+TeKo/Yn2ROzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7ApKQuZvOdAuhtFDKKDijSuyrJpTYz3GqK15EGCoIw=;
 b=nLW0JnbwjihiQiLe6BppxBNfRsu3JweqE4RNdBBnMyFTJ7ABG2aDid0JngmGVc9+XAQpmT8VN4PJDJBezhKHlLbt/YrPoCW8RNGem++ZpBHM36Sf/c/b6Rtt3Bni4RcVdgk1K5FPBE1rgP2onUOK8LeTitxPU+E1w05q2ODh+iYD2hxo6308lxr/q8UMCS8F50P4alq2t1wvFK97MyopukonzxnTuwPWaa/wbQD4G5oV9ZD2n9JPTlUOZqocW9HmTNq8Cm0llKYY+3dnr0S4uHN/348IxwNaORyb7muzSOPMIC5P9agthNsFCEZxp1RWtUTZ3ndvBP+1vFP6tqL/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7ApKQuZvOdAuhtFDKKDijSuyrJpTYz3GqK15EGCoIw=;
 b=trcNJkdhus8gwCWZAN5EhzapNPnNePbrPLxDaM4blHLyZpCVXQ9WEKEppXykyyvKJqAAycpDIEVHmBrhr8UgJfGIK6oME7f8JNj3x5iVCEh3jrqwDo0kMR29GB74CMiDHeTpyxYc+X+3jZDTArpQ5w8fn72UH/Vds8BFX19EQ5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH8PR17MB6810.namprd17.prod.outlook.com (2603:10b6:510:23b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:57:51 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 19:57:51 +0000
Date: Tue, 9 Jan 2024 14:57:42 -0500
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
Message-ID: <ZZ2lNoTQ8hDHADTT@memverge.com>
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
 <ZZXX95yvk/WTIBT/@memverge.com>
 <CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com>
 <ZZwtmiucNXxmrZ7S@memverge.com>
 <CAAYibXhfUu8dMwvBmWz4P6N9-yLao0QwAFozk4rS_0GPsEZd7Q@mail.gmail.com>
 <CAAYibXgf6i5+aqopCrVu5ZveDJ9WP2M2AJaUUaj5qFXFHQQxmQ@mail.gmail.com>
 <ZZydwBTS4NeSizzb@memverge.com>
 <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYibXhY5p6VN7yAMpmfAgHO+gsf51dvNw68y__RYV+43CVVLQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH8PR17MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a01937d-4a92-4cd2-21de-08dc114d429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9NgylcsxBMmoInpY9rxJngs/XFEq8WZUcZx9HW2u+mbXlKpddX16hu6UP5+Lpo8QDuEo+fNpIlh29rcUagNUblHVCGx4XzEyjYfw0JhQgn33UqrjTkw5LWBtu3QzRZG0EI6V4TkkAJfGF/j5PDU2cfAKOz87JcHuvNAR7eOIxe2HJgiRNGhXymXjSQLB9dzijtnW+WJowhQGLMKwds/SZTBmlq68s3V2i5GEXdCg09tDGxL8xKtecSI2LytYnemrZcreSdBx6G5Lxkhm3r1BKPZQrxbtbEc2pOkXOFFKdlnIsK1wyP50D/zNebhtY3qvcCQdhgYWlJiLh+RzH+Y0SiF02o8kS48IP8fk/rmlPyxgR9Xv7WNIwWpnN2Z0KbaoXJzm9PA7T2zZqgiLehn9vPCczdmoOSIuwCOfyZKqyJ9siS+lXRge7jIjSgFI60mUwA54V51VGSups5Maq8PlCRTaIjDDM2fzY+XYuY7QLAKxKhRZI+Bm5/Yiycgcd2RA8e/faoXt6RoLgShfTqUgXmquZ6gxXKPQWjuXH+BwLve3s8sQ+ffWFIx1O6nU/tQU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39840400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66556008)(66476007)(316002)(4326008)(8676002)(8936002)(478600001)(26005)(2616005)(83380400001)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(6916009)(86362001)(6666004)(6512007)(6506007)(6486002)(54906003)(53546011)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU01VDR6MVJhNWJXenFDaHdhVlJTTFZHOURwbHYzdDBCYkNheWYrUjlGV0tB?=
 =?utf-8?B?MDEzcmVuTWY5M1JKMDdpVjBJNTk3SjA3SGkyUTJnUHRGbTAxcEdFclQrMmtJ?=
 =?utf-8?B?dGJEVldlNUZ2eXphN3RIV1diZnVsM3Y2T3U1NnJUTlJPblcrMTFXQVhEbWp4?=
 =?utf-8?B?NitSY011L3MzcEdLSXkyWHYzODd1eXBaYmZZU3dSRzdvQVlyZXhHS2dHbnRw?=
 =?utf-8?B?L29KNEVPUlVMcEZrcmNWMEdBSTFZRHlPeVI4MjlQd3dEQUluQVd4ZkFXdG1s?=
 =?utf-8?B?QVV3TGtQQUlGSW9aSGZmYmE1OTBGVWdqbXFSOHpEZHI2VkR4ZVY4NldZcmtP?=
 =?utf-8?B?RjcxSFYwNnpKVnhpVlJXR0NMTUoraUxZRmFVSkpUWXNEU1NyQ3ZrRHhuUTIy?=
 =?utf-8?B?UkUyVFJlU2xkQ1c0QVJuRkRVNGJVYThIcTkvWlNtZmdiUXdKNjA2ZERFMktp?=
 =?utf-8?B?Ynl6NDRVVDEzZ3IxYitscVd0SURYbUFjenhqTE9zNGFhck1tV3hNMGlwbHdt?=
 =?utf-8?B?TWN0TVJJRThCT0hCTXUvOXp6V0thTXRVODVqajZKK3BzbmJ5N1dmMHNiVW9z?=
 =?utf-8?B?OTFQUWFhNm1YYlYzTDVDUzdYWHlkWWE4L3R2MG0wYXlyZ2xqR1Z6MEMvTjJD?=
 =?utf-8?B?OTk2bHBNQXNCd2VFKzVzbnJyMVF5MDR2M0dEZGMyQ1k2VjRuQWRXOXU3Q0E1?=
 =?utf-8?B?K1lUbmRkangvbzNDV3hjdjZEbDFOUHk4cDhPS2N6NWl1bU90RzRlYVgwU250?=
 =?utf-8?B?MkhocndEcnJvbjd4NkNUSHdEM1dFWmErREJNdE5NRWMyc1RoMFppR1dZbENu?=
 =?utf-8?B?c0NOcXJ3OHdpOURyZVhMeWppbmhzcmM2a0pXckprNzNFN1pPN3BCekVFM2VC?=
 =?utf-8?B?NGExZ0xhNW1QZWFzM2E2aTRxMXUza21VeVRnUnNtRWZRK3NtYVJvSDFYU0tz?=
 =?utf-8?B?bnIwNUZvMlhvZUdyY3ZxV3Urb3V6YVNjR3BuaWFEZzB3eU9ZdXNrNStaSFJK?=
 =?utf-8?B?MTJ4c2ZPVUM5UlFuR1hUNjhnL1JtZmF3SVhhaitFWDRFRkh1QzQ1VmFZRCtH?=
 =?utf-8?B?K1pQQnlicUMvNndVeWJUVWJsSUp0QnBpVC9mQlFGdmUwZGdCdmpDd1FGZmw1?=
 =?utf-8?B?MlZKWWw1SFBXejF1Y3ZpcFFwUmJ4bCtxK24wRUd5MmVoMCtFanBMNHloWUU4?=
 =?utf-8?B?TW1MRk1zYjI2dCtBUisrOVFEdGR6cFRGcUlnNDdUTHcwTGR1QlhxUkZRMm5q?=
 =?utf-8?B?ZytrNW9CQVhTWEZPU2xRSW9Jd2ZhbUZPNUliQUpkcWZJUWd5WW1VWW9CelBl?=
 =?utf-8?B?VE9sTldHbzE1RlNZMWhXVVVLZTZLdU5mUXIydzg3VVBRN1N6Z0ppWlViRFZr?=
 =?utf-8?B?WjNsNDI1SmNUS2N6MmJXRmt6MXNZNk5nWTd2c1ovYmk5aE9HRTh5YzliZ1F5?=
 =?utf-8?B?VkZzdzdlUlk2V3JabEpiejEzcTFMYXFsS1JZbXpqQWc1RkRlbm50dkU3RXF3?=
 =?utf-8?B?K2FnTlZDcU4ydmRsUHJqMm01OHhScnJnNjBIUDkvSVUrbXc4US9WWk94V3FO?=
 =?utf-8?B?TXBIWGhpa3UwcGVhVmhTaG9mZmk3cUdCdVVKUVdNeFIzQll5QUtYdHEwNDZa?=
 =?utf-8?B?djdabDJIK0ZaVGhIcE1lUVdVQjYyS0g4ajRLNnZJNURyb3I5Uk8zSlNrZlBz?=
 =?utf-8?B?MGcxVTIwdUdHS2FJNWNwMHJWNzZFT0RDS2FJQUZGeHlVNnYxamNxUWdmVS92?=
 =?utf-8?B?NEZtUkdLcDFGVWhWcy9VYmtKRFhoWU44eVpSd3RkS2RqSHhFa2tjTjd2b240?=
 =?utf-8?B?enNhamtiREN6NDFzbjA2WG9mL1RpY2IwZ2g0YldXdVAyVWZXaUpGbmF6a2t4?=
 =?utf-8?B?eHNSMnlvZmpudXpkZzBwNVgwT0tOOVJGUEdSd2RHdTZCL1JTdE10T3p1cFdl?=
 =?utf-8?B?UytURkpFeEpkZURMeHBvVngxTnQrL1I0MzJmRjFrTVUrU0VVNU9PVkdsdFNU?=
 =?utf-8?B?T1VSYzh0N1FQbzBQQmpOTk1zRlRid3lyb2kyeGJzMUw0SUJLVm9KQ1ZLVkV2?=
 =?utf-8?B?Tmc1cmRDZHlVY0FOMytaRzdvL2tWek1pSk5TOEliS3Y1SldEa0diTGFtL0FY?=
 =?utf-8?B?SXJXOC9jR0dWbFRLUzlFR1RtSDUwWm1aZHNVc1B6VkNlc1dIZndndmI1MXZr?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01937d-4a92-4cd2-21de-08dc114d429c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:57:50.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6W+lfJ4cWqhHqv0I1I2j7cNdRvLpyhk0b+JTARkQ8U0DAFAL17vi16NNcUPSwqeIFFo5Qqek7gbFRrDXgVI0M8Zte8v+Rz5VEDOoYqI7YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR17MB6810

On Tue, Jan 09, 2024 at 11:33:04AM -0800, Hao Xiang wrote:
> On Mon, Jan 8, 2024 at 5:13 PM Gregory Price <gregory.price@memverge.com> wrote:
> 
> Sounds like the technical details are explained on the other thread.
> From what I understand now, if we don't go through a complex CXL
> setup, it wouldn't go through the emulation path.
> 
> Here is our exact setup. Guest runs Linux kernel 6.6rc2
> 
> taskset --cpu-list 0-47,96-143 \
> numactl -N 0 -m 0 ${QEMU} \
> -M q35,cxl=on,hmat=on \
> -m 64G \
> -smp 8,sockets=1,cores=8,threads=1 \
> -object memory-backend-ram,id=ram0,size=45G \
> -numa node,memdev=ram0,cpus=0-7,nodeid=0 \
> -msg timestamp=on -L /usr/share/seabios \
> -enable-kvm \
> -object memory-backend-ram,id=vmem0,size=19G,host-nodes=${HOST_CXL_NODE},policy=bind
> \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> -numa node,memdev=vmem0,nodeid=1 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k

:] you did what i thought you did

-numa node,memdev=vmem0,nodeid=1

"""
Another possiblity: You mapped this memory-backend into another numa
node explicitly and never onlined the memory via cxlcli.  I've done
this, and it works, but it's a "hidden feature" that probably should
not exist / be supported.
"""

You're mapping vmem0 into an explicit numa node *and* into the type3
device.  You don't need to do both - and technically this shouldn't be
allowed.

With this configuration, you can go thorugh the cxl-cli setup process
for the CXL device, you'll find that you can create *another* node
(node 2 in this case) that maps to the same memory you mapped to node1..


You can drop the cxl devices objects in here and the memory will still
come up the way you want it to.

If you drop this line:

-numa node,memdev=vmem0,nodeid=1

You have to use the CXL driver to instantiate the dax device and the
numa node, and at *that* point you will see the read/write functions
being called.

~Gregory
