Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186461DA28
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="VQYT00u0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4R7S8pVJ2oq+9bpSQDrGwRJN67DLT2p///xWfQfHexYAj4RcfQQIV+ojKp2XNqHUTyjR7CWsNbteMXCuJwUMD5sy8kiwk9Z1pmmVvf5yWWM4XW8WOszJXze1WfCwzmzyJstMC/HWJl0jbJTAKs+R1RQAZ13ddlVIwF1kAYxvxg8lhSFQG09cv5dt0yWfYsKVOwdtHUNgkdq0qT5gJOBTXEo5obX5mgEAI18LQ9UhA5IwrYbqUCDD+OtROrHhGnpHih/Qb5D2Eo5pOi1BBaMrPWkOiJcZWKP1msbaE/pH3H55QdBCogNGXZrXkQT3vf8WeBUu3U/I6QKTYpGhlJ3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppf+29AthgPEXhB4zsxLYqPB7P5PUGMjN1VJN3FxdLk=;
 b=SbDaR3yP0zCcI/RjRXmj3bLGAHapYzYtnwBBTpB54h26zXqC0zNHyc1wswXgPhbRYdSRTSmYJ7UhG8aSPV37u1ZSOjcQ011h01Gv/BDesKTvqrmPW2hsQsSwC5GFwN14QA+JdpzWblKcDFKEreo6xHXir10cEDF8p4xJhuHAcj2m2Bj2Ip1u8m2KyIFN5lXdfaFunECSyr6D70+9tLlTVB0aEOkhjNKZLM/jqgObBuLP9jdC7Om6CW1s5kIzO4hvgCYi2/M/Nx9PgHbPo1yozFumr+7VdDuGyZnq4T9yoRH5tq+2sADPgZL/drjyI25e2oRafPy4CR1VJG6sdUUe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppf+29AthgPEXhB4zsxLYqPB7P5PUGMjN1VJN3FxdLk=;
 b=VQYT00u0a1LRDTups8eCpm9pdRHWyU2WCv7brQVTTHCHK8p4AmnVcwerayae+wy/ixBEjtFumoOPSDs4YGB0TAgDhqcNfzyhwOn8N3pc3LGLov4Uh59wIaicINBj9AZnOlx4aCs4C7UsmMkmf4lLhK4H+QhKHu2OKu5ZbI3m/Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5613.namprd17.prod.outlook.com (2603:10b6:510:b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 21:56:21 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 21:56:21 +0000
Date: Wed, 3 Jan 2024 16:56:07 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Hao Xiang <hao.xiang@bytedance.com>,
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
Subject: Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
Message-ID: <ZZXX95yvk/WTIBT/@memverge.com>
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101075315.43167-2-horenchuang@bytedance.com>
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b39b38b-c6a5-4c0c-7341-08dc0ca6d26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k4ECk77zHFn8zwii/5s1+3gAycIUvdQfuwLDLpYkhj3Sm634yKGqX/NNuXpZOq4U2letxH42R8DzPSWZT12xqapWwOGOFkir+dEqHQ7nbkY6PXHINUHyP1Od6dKBCjeu7ViaEBcP5Egl+ZbAWjDKyKzesrjyG3MfsAbBYpjz015LUqDC/aJjQnxhJ8HFu0U7j/UdTKnfBcnA5naEZudlp6YGOldq5n9MYqcgY0ddbcc40KwtdNxmP8mqcRZQekBItIK+52Iww1FJR052w89y8acRlYh5dnachfa4X7P5Ft8SZ0biPJMEvwic/tgyb2qUA6OiP2t4JrPtw6H86ZAgo57A4s6j8d5BYKTiv4RDGFbSuuY1N4SaVKGos2Wny0lPhjbRkPLxGKHOxG771WKNbOWqN0ZcjnQ88b6xApWKNktmU8CE8Yk6A2VhuqHdhRuxn984EPuuuVpWGQSKqxcj26j2cuYao664i5YykApKFRFPF4AhH6uXqvsyk7933X+WF/OBlggl1e0XOg9MxIPiqbFY66XKoruH2zXnecXrdtfVT6bj3XzrJNMWbO3eJyxc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39840400004)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(86362001)(36756003)(66899024)(6486002)(478600001)(6506007)(6666004)(66476007)(66556008)(54906003)(66946007)(6916009)(6512007)(26005)(2616005)(44832011)(2906002)(7416002)(5660300002)(8676002)(8936002)(316002)(4326008)(38100700002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1K1P4cwk6t1LP9be3m2PPWeDVcjPJBL97eHlXvnSaU2IJV1SkDeZ247spSCq?=
 =?us-ascii?Q?WkcmrQUy44YhXzNE+CRY8Mzfl65WjkQRMTSjVfncrjKIImgCAwjJ1uckMEh6?=
 =?us-ascii?Q?L9TZtg7k2edJj3aR0wkTMlJ7avInhvQmrod8prsJlWYi+tixBmmHZiiUDVjm?=
 =?us-ascii?Q?0g3bLsNGCD9p2gz+BPZZ5RGkDnSWJzTDMNmZZ2plqJp9pDy/PHM+w1H5W4Hl?=
 =?us-ascii?Q?UuK95aDjec34oLJXSDanh/LExJB7PiKDchgGMyw/vUFjNLcYPnh9ci8eDMVA?=
 =?us-ascii?Q?ij8I3cVkLNxkDBCE03NNrA3IEYvzGcCZmCOK7KG7GLRyI95NW6ChQb3lT+EX?=
 =?us-ascii?Q?zCepBDv662GQWuN/LPwenv+JShwoggNNYuCK24JHafXdEf/VXCIh8o3Bnu4s?=
 =?us-ascii?Q?vij9plc5EFvV95IwV2uaVHA2jEzqoB/G18ZEutLtu6An4Dss3JJ+wKZimIOX?=
 =?us-ascii?Q?sufXcxcjEwPRcThFbj0Km5OoqZ1Sf4kGAcNl37ulWZT4nFFoyo66mR1cHBz3?=
 =?us-ascii?Q?kFHUDzT0s5x7heLrj7tpMzajKLHYtSEcXFAW1oP8tWxy88xLmdVGTIo0TAJP?=
 =?us-ascii?Q?01nIyiQC3DM49AWf1OD6CJ6QkHkIr8lClN6SeKW0+aB6TH25qdhmsndzeG/h?=
 =?us-ascii?Q?imsPCYLupOK6PldtB/UFfablc90I4gW4dKFqM/yFZBUDAYmrgRiOU9s8sJx9?=
 =?us-ascii?Q?fIDr7MAevwKjB28A61JMh8Nr1bjDtcRTskeDWcPdHxwhxTGx6HBN9MGxJD/X?=
 =?us-ascii?Q?G00DOnubKvs6041FPSGiI3RZAEV586brxvTuE51q7wKe66xCUhtnJLhV1gYa?=
 =?us-ascii?Q?saXtB9ZcK5QMO/jDONO0zJ1JlT5Z6E8HsDqcrzZme31nLxo40SgbrbyF6gLV?=
 =?us-ascii?Q?4XmB/YyPxyFvQbKhPkVVOpo1ZFKdDw0z3+SukJoOiW3ePJL0nX6IZQNQtMWJ?=
 =?us-ascii?Q?oqyMdq7cMqi9JjMbcT136p9gdo4KXBnYpIm5MmpfMKMkZlY5tRBA9WWxj2//?=
 =?us-ascii?Q?Fsg9OdLYpJrnVP6iE6frag7Plzq6iLmx7VmqtjTYgaiPO6mZcKfObW8L0Aj2?=
 =?us-ascii?Q?9tBQ6IbwSuAHX5GKm0Fivs0zK8A4pCtxniEERD5xNWY0mYVck5sYq1gTAgMC?=
 =?us-ascii?Q?tal+qKwN0cDWvLHdTh1mjIGOeaJUloCZf+Q/moUqbvG6bRieFWqVf9t2nJNQ?=
 =?us-ascii?Q?UH3RTNyx1VJYMtMSCwJBolgMFRyf6QA+UWO/acM7UdYA6jjbzQAMesfaIwCy?=
 =?us-ascii?Q?1SLxl1eHOznByUVIGnf8or6qO+6+ZK9Pu8Rmh7If1J2HzwdGVYBd28t+gDYR?=
 =?us-ascii?Q?GBnVhOIYaizatMpx/6DvCkeByrzCT71q17mLhJ+aKKV5FFFOmdNrwJAuR/d5?=
 =?us-ascii?Q?XEIT1Ly/HvAlvAlVBMS6KyT4jJVdbqYMU1M91TD509CNtbLLl4Yd1fpkQ8eF?=
 =?us-ascii?Q?4NRfxWDn3Yrgz6N6uEerxBi844LzqLO3WWGNqoN3zjZsNhi9dfv+pYMgEQTx?=
 =?us-ascii?Q?XV5lKyTw+Qp3m8QPg05EUU8EW9yJkKrndmiJa1BDjNKFQ5a0atGhC+GjhYFi?=
 =?us-ascii?Q?zrPjtsOdaEalloc5Q8N2G9V5H9sDzcl6eRRNIKvLx/zkshQncW06ZExI8jiW?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b39b38b-c6a5-4c0c-7341-08dc0ca6d26f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:56:21.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1h7EpmXRs6CkMIFm+qg7Umj8uDHP/TlmgZJrhTrs8Fw0kbkpkcY1HPh5nrc7lEm+RG4EaxaA7MwfOVS/fApeCtxiz934Uc+eWQIiNIyUa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5613

On Sun, Dec 31, 2023 at 11:53:15PM -0800, Ho-Ren (Jack) Chuang wrote:
> Introduce a new configuration option 'host-mem-type=' in the
> '-object memory-backend-ram', allowing users to specify
> from which type of memory to allocate.
> 
> Users can specify 'cxlram' as an argument, and QEMU will then
> automatically locate CXL RAM NUMA nodes and use them as the backend memory.
> For example:
> 	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \

Stupid questions:

Why not just use `host-nodes` and pass in the numa node you want to
allocate from? Why should QEMU be made "CXL-aware" in the sense that
QEMU is responsible for figuring out what host node has CXL memory?

This feels like an "upper level software" operation (orchestration), rather
than something qemu should internally understand.

> 	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> 	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> 	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \

For a variety of performance reasons, this will not work the way you
want it to.  You are essentially telling QEMU to map the vmem0 into a
virtual cxl device, and now any memory accesses to that memory region
will end up going through the cxl-type3 device logic - which is an IO
path from the perspective of QEMU.

You may want to double check that your tests aren't using swap space in
the guest, because I found in my testing that linux would prefer to use
swap rather than attempt to use virtual cxl-type3 device memory because
of how god-awful slow it is (even if it is backed by DRAM).


Additionally, this configuration will not (should not) presently work
with VMX enabled.  Unless I missed some other update, QEMU w/ CXL memory
presently crashes when VMX is enabled for not-yet-debugged reasons.

Another possiblity: You mapped this memory-backend into another numa
node explicitly and never onlined the memory via cxlcli.  I've done
this, and it works, but it's a "hidden feature" that probably should
not exist / be supported.



If I understand the goal here, it's to pass CXL-hosted DRAM through to
the guest in a way that the system can manage it according to its
performance attributes.

You're better off just using the `host-nodes` field of host-memory
and passing bandwidth/latency attributes though via `-numa hmat-lb`

In that scenario, the guest software doesn't even need to know CXL
exists at all, it can just read the attributes of the numa node
that QEMU created for it.

In the future to deal with proper dynamic capacity, we may need to
consider a different backend object altogether that allows sparse
allocations, and a virtual cxl device which pre-allocates the CFMW
can at least be registered to manage it.  I'm not quite sure how that
looks just yet.

For example: 1-socket, 4 CPU QEMU instance w/ 4GB on a cpu-node and 4GB
on a cpuless node.

qemu-system-x86_64 \
-nographic \
-accel kvm \
-machine type=q35,hmat=on \
-drive file=./myvm.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 8G,slots=4,maxmem=16G \
-smp cpus=4 \
-object memory-backend-ram,size=4G,id=ram-node0,numa=X \ <-- extend here
-object memory-backend-ram,size=4G,id=ram-node1,numa=Y \ <-- extend here
-numa node,nodeid=0,cpus=0-4,memdev=ram-node0 \          <-- cpu node
-numa node,initiator=0,nodeid=1,memdev=ram-node1 \       <-- cpuless node
-netdev bridge,id=hn0,br=virbr0 \
-device virtio-net-pci,netdev=hn0,id=nic1,mac=52:54:00:12:34:77 \
-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=10485760 \
-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=20 \
-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=5242880

[root@fedora ~]# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3
node 0 size: 3965 MB
node 0 free: 3611 MB
node 1 cpus:
node 1 size: 3986 MB
node 1 free: 3960 MB
node distances:
node   0   1
  0:  10  20
  1:  20  10

[root@fedora initiators]# cd /sys/devices/system/node/node1/access0/initiators
node0  read_bandwidth  read_latency  write_bandwidth  write_latency
[root@fedora initiators]# cat read_bandwidth
5
[root@fedora initiators]# cat read_latency
20


~Gregory
