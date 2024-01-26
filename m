Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEE1D524
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283832; cv=fail; b=LzKbu+GUcuqp/m/edCsI5WLOPDjsCGJ9eIskTvyl127xkj6GuS49CgWpuuWLP4lIgxxiUovA+DxBw7eNZwhm/7g5ie6h5z7viB9tvW4yhtCxGx7X4WBb2y2/k2SsO49o2aqH8w7LKwQ0S5rAC8NVuBOyFdwtlSqOuaVfFav7mXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283832; c=relaxed/simple;
	bh=tb+mWx4tASGJLLE/q9trbh5KtfV14/ZhMKIkSCsZ1sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iKkpAL583Fv0s8HG1g07qwbFXaLCeyybN0TItfDqv5I9oAKKhM+lsVPfu5aqGt2Aa8qmOg+jN8eBZ4Er8SbJFdc35aaBVvibD3KZDDFFm7OMejqioodjRs4V3GRIPYHYk8sMMKX2pbcbg0dUi2yWL0hxR5SV10WXQgCOyEkF6AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=pxn5IFgk; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="pxn5IFgk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0lvNyzbnf34KKkT2ctLCKkKJjxiDK9sfVOiEFPiJ+039G8oYksgLQrXTf8tjyGwLkNk3O7d7FH74O8rkFsxHIPOATtqIXvgOFIuO4s4+srUx/H97CKAO48bjmM4cMTR+tanWMRVimn0Zox4afMR27iM/35bh67AcnKB15egb7ohQccASgWK6LSb9WON7XcqlSo0ozrkSsw6k2+fiLBSmuUBo9qriw+8FCsHfjkhgnu9svhXTTl/w9zLy2FlyMEVeQhaz3frLKh2Mqouqrb9tIjdjvf05w2rqdy18jQNAsmw2RaR4Ojv2IJqlsGIy9CFRPdM1++C0o9qNRmTyvdWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wqKN48ZNe/jsRKHxjn3KDQ2o6yBLkFUD7Ou7y1+5qk=;
 b=UIryQHpdsZfjoaWtYeLE2wfhIaGS8aXkYT3aWeCNNW9OxGzv8QiBWDsPy2VXovyPWhIuXuDo325BopWlfk/++pgK6j1ibtpqJZVFj3yF2PbAxKQK7xLE9VI31ktwFc5yvUAhkptt3nuWTBbZVy/sfCkTWgwobzGV1mRiqld2+AGwhORZ2QneVJr1CwEpFi8OiN4jb6riwmUmhfM1Vk2JxhAI3NYltvwJtMDBu+YDWMltPZ5QP2cTUysUhM4QBiW6xc4oltg5Ld8wOERU3tbf8foFOxsvUMJ+FpI6mjqrwKsdlAj2JHpZtcclLaYWQKHs8xeh8MxpLmbAnBQo5chjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wqKN48ZNe/jsRKHxjn3KDQ2o6yBLkFUD7Ou7y1+5qk=;
 b=pxn5IFgkMDvjaigjb2m5wtaSLsfSJKjvBq82qNzteECLxer620Gh23JM77rPuIO32fl2uX20Z/W6wWSx7ZabShxU8A0lb82j4LfOMCeH+skY3SR3T5MJarDzzoEFgySzwAeew4WQzYZx0tUERD1+RH8iBLaSKuAFWtrO46q63FY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB6006.namprd17.prod.outlook.com (2603:10b6:303:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:43:46 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 15:43:46 +0000
Date: Fri, 26 Jan 2024 10:43:43 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sajjan Rao <sajjanr@gmail.com>,
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	linux-cxl@vger.kernel.org
Subject: Re: qemu cxl memory expander shows numa_node -1
Message-ID: <ZbPTL00WOo7UC0e6@memverge.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126123926.000051bd@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbf0bfc-dcd1-491b-2465-08dc1e859550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lZrT34UlTXQN9UIChCeKxdJ0d0OvQzd+eGJmdVtIVmlLy4oQ6sti9c+LC9+dbqYEUbei37Qs/x3SnTXUiJPcZoAF+b7y3VD9SKRmRaRfBWtJrX0O/bcaVpKq7aKDqiSdXNMSFXqY1ab4wg+7mmQRxWUnn4DLoyltldvIn5MUIOvNklnwnv4XrMaia0v5ECLGml6YEHNVxHT4Ra+Xb/C0MzUlvjz3zg5vZJaUjGEmNGO9hVMl9TNjWOTFk+Z42fwUuOfMf2HQ3GuVgp+RPubt669F2fwb8/uba+Msv9FYFh30TaT6kfKNq2NJcmTJZ6UoFB7gS9exCgU+idMKQ/c0Kg/j5UenYRpyatTVJ8Y0/ZNEHizhSJaum7pzKUzcqu9jF4vpM/9m2JyayYDFnFrjBV9fkYXTqQ35SM92cw9ScWgPKRuaMJxVfufLePRD1TOhTmj3k8uqA6wPL8gwEXg3x3PFvtG/WoPp94eTauJzkUdd9VoZ3rWiz62Kpb6PXISMaVb4Nn01OmcaZN3l975q15LPDrLabed3+3ffwAKUYSLxPZChE7mSP5NswkklJ8sc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(6512007)(5660300002)(6506007)(6666004)(38100700002)(2616005)(83380400001)(86362001)(478600001)(6486002)(316002)(4326008)(66556008)(66946007)(66476007)(6916009)(54906003)(8676002)(8936002)(36756003)(44832011)(41300700001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KpR+m7FmUTwxAlv5xID6vC8HZ+6zfHDYknbYU6o1hCHNxVf9FIH70xjpSZ0n?=
 =?us-ascii?Q?4Yyqc390A+6yP94afrxLq4cm7wZEvDqNewLmU2JLe9oweclyQumQat7egEx/?=
 =?us-ascii?Q?94uH9aS8a6BQzb3vahcQswjEegjEeb7kUz1wlFO3TFRMVk6IE6QyzasEBFUx?=
 =?us-ascii?Q?ne0Hdu/86GFVV8rFlHFCCxvqhu+KNSXhhKt5AHXZ8KFc85fU5CmSksk/AWjO?=
 =?us-ascii?Q?CfnZMgiH66RjK36/K5APgYHU72ANorGRgY1aqV0eroPC5STwe/AGSBKK5ce5?=
 =?us-ascii?Q?VvYFBY+BWSv0ph4sR3gi2V+Jcoxk00pkpeWUoBLXdIBTSdjj7jqnG018cuvu?=
 =?us-ascii?Q?av41ppzR5DbxkzANzcll1jzH7duok5TVwNlvWI7laqFkdMtEf58tTPsIlMDZ?=
 =?us-ascii?Q?VAqevvMMFIqaqKqiL2Eb7WUYcJ5U5VOBLHbMQPMnPtvz6WdJ569Ob+MSs5ft?=
 =?us-ascii?Q?FQeWVM8yLmjqfZGTJljqcKdSMme3kfU5vvg8I804/Zd4yL/sjCjsXB+IG9ev?=
 =?us-ascii?Q?0Dlfv32gBQA2N56ci1hEx1sYDMeZuZp0YM9UhLAc63vvXHB5KZ7WeuuNVcCS?=
 =?us-ascii?Q?pX2IiPbHL2NUbzDXdLUbw2W/Wx6SkRPsxWS1oXoJlaOUtRZOedEM7jlhVVUf?=
 =?us-ascii?Q?Zi29BBWBTBDNauACzTT+QnP+hAg0QToX0cXEHQ7Q5a6vHB5iXySXrVtf8Y+D?=
 =?us-ascii?Q?tTp9SW8r4rKL+ooaLpA8I4I1r5+4xrj0XhGhzKx1ZHvgSoQiL+ezzwGEVfgr?=
 =?us-ascii?Q?G9KpyXhVp1MgkmwAvMXPs3C2D0jZ2d2r6wJeA5SOO/2eg3ombv3xBdlaKaHp?=
 =?us-ascii?Q?lHnwj38sc8ipFFVzbrRpuJCq3i5w1HTA7c89Wic/xSCINUiK4vS5r9qli5ms?=
 =?us-ascii?Q?E41+J+Q45RV4Lj9Jq64hDd0CEV4l0UKPN7gNOS5diSNo+CNQVwd72FNl5Yx+?=
 =?us-ascii?Q?ateNFPdLFUsp3EIeS5dhwnNqknlMoOlSWk+KC5AC8FA0RAdIxqS5pSikrCwh?=
 =?us-ascii?Q?t8HIE9C013W6fJvFYJGdZDolCUXmKpnQM+Q8bNjzdUtDHeKR50oacqCimxvA?=
 =?us-ascii?Q?Y4Q3KudoHQ1Oz7FA6ccyS1bWDmNZCwMXEnosKutsqy1qY7L9wqqT8WS7uQg5?=
 =?us-ascii?Q?TyWO4QLMsKZkQdTluyVpU9bXmKSUGilLcmZr2UvfM0+tigxCWvg9dKIo2wQY?=
 =?us-ascii?Q?MTvDoQRmZKKljky4bs+F9hAlnxt2TKWHiEv6qdc1y0jlwA2izAIP8C6yjLdm?=
 =?us-ascii?Q?bBagp1vIK7qBjFWyMkvM6bfv/3wFJGNC7WWTo2TuwNlx3P2e7oi1CYsHTfvW?=
 =?us-ascii?Q?zPr5z1BjouKtopWWhDmDps48z0V4Iq8R43rojp/sQxR+UKB1NjZ3bQWHJwD8?=
 =?us-ascii?Q?qWPA6s5a2Le0XO0KMsBL6jfEvo3I+x4S3nmlazecXLd0F6ym3zqJ1A76Xfj7?=
 =?us-ascii?Q?9yPvNQ+camdlFl8ra0sup4NsvPZdp0AKGWcvbQ9d+7EHAtjNoEyww04mWSL8?=
 =?us-ascii?Q?y0pJrihH/obP3FAu46LqTPMwRzOhboYSiR5cYuuvjtKNZHJYZf6m9nuZdjAT?=
 =?us-ascii?Q?AGlHfxvaHW65T8Ti4/Mx6HkoUXihP+tneuexdeS0yCo4GRDgxhgtejv4o/j3?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbf0bfc-dcd1-491b-2465-08dc1e859550
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:43:46.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvOaC6KyqAt7woWxR7tbqkfK1j0xnTs1xYnLI5XoiMMKVTxPbkN3sZRsoMIBjJmAlLT6O86a66Vmpyk2neUTFmp3bIRi20BSZOtt9mOVtw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB6006

On Fri, Jan 26, 2024 at 12:39:26PM +0000, Jonathan Cameron wrote:
> On Thu, 25 Jan 2024 13:45:09 +0530
> Sajjan Rao <sajjanr@gmail.com> wrote:
> 
> > Looks like something changed in QEMU 8.2 that broke running code out
> > of CXL memory with KVM disabled.
> > I used "numactl --membind 2 ls" as suggested by Dimitrios earlier,
> > this worked for me until I updated to the latest QEMU.
> > 
> > Is this a known issue? Or am I missing something?
> 
> I'm confused on how the description below ever worked.
> Assigning the underlying memdev=cxl-mem1 to a numa node isn't going
> to correctly build the connections the CFMWS PA range.
> 

I've now seen 3-4 occasions where people have done this and run into
trouble (for obvious reasons).  Is there anything we can do to disallow
the double-registering of a single memdev to both a numa node and a cxl
device?

~Gregory
