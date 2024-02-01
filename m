Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676875E23A
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807078; cv=fail; b=DI+9c9sEKc1DGMOInmSQZ9mGSu5itopEq689MNROEcrf85VqEt5JXGcQRfv+VLsqnuijMSuaXkf5FyrbRL8r4OYevuENWWq+MLt6vAIWoNbNgYDRQMjzNqllmhNtkqsK+fDfuRxFZgCTCTef8p7oNu40Y0F++ewC7Qpxbd4zMwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807078; c=relaxed/simple;
	bh=0ohkm9NVM/3Xt5gPbETB3q1QAzXiChb+QTe52dmrhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQtOtyQr0FMPqSbkgwiT9klChEBCBXhWdmCcx1mVJm6/3olsZ/X7WBru0h7JZgEZbmKuBrCrhC74zSpNFq9RMRRXuFNedm5c0xLgnVKWBqQgsS1jXPNJgTStC3LLZFvGPtvOWeY2H4sEX57KnYWVuzDYHB0jUqIbs4i5Nb5lQ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=fail (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=qJkU3WX8 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.220.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="qJkU3WX8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksTPpOkA6kfCFTVLLAMTkvuNbBxiteFaXCXyRYxV4KGX2sX6zH9fp83LiAKDWqoc4VZrMkvdba9YAq+YNXWuUacP4LxEyqcK8oydM6aQ5JXW33Hrj+wPdZbgvzVntQufEJljcGGeEXHgTfXdc0wys+mjZ0WGjKD38gI4dc9imI/OF+Lrtsi7tP7fHeijOBk+M/qv6rObiNocG5kvOthIPfVcIWpyS0KRgK4QMDStYGQluWtk3bhFhaVN4zmSBQH79vM4z7CusOP2CPmTXJJ4Sp3S+Ral4pr/1xIez7QM2qDRRWXQmFUke313oVUiovTrD84xRnvyAFq6QjlcUGEjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbM7ZuuFUzMsuX4ubYsmfJMWYdpQIWczUtFu5LQFxis=;
 b=KgocCyxDtOXFIPsg0VLQAV0h6UJ76/ctB0m3cRkPi4Hi5ScVMQfe0d2jawFL7atTzNXRcTN+AEylwx8DsVzhaESoRbxht4DV6en0WAtxvUUrOSfK/JlcdWQLE9volG+SGSPNyTM1ZgYwnPSc4A4L8AS4fAK++Lv4qUKosOEL91T5M2DA+CQc9t5XZXmPTkONTmQFfqXN7mOEkvnYElWD1E6w7n4iOi4Ss+x6KaPdcAG89V18btFaVOu4AA/L8N8oYDwesImvTuTjUmsiPwj1RQip0sn18UHV/dge0OqWREG1jT9AcPiWfYkxXCuVZaX3hRJDxuCnD6flJ4Iua0Nsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbM7ZuuFUzMsuX4ubYsmfJMWYdpQIWczUtFu5LQFxis=;
 b=qJkU3WX8GAsgcFA1goRfMy9N/QGRfX2TtbLjp5+ImNAR/3SBVzjtBR15CqgfKXJLABvYo9Vkfcwu8ArEVhDLO8jZ5BxfCzHprc42FtIxcx8hLp6FFmIe6S8q383MbieKzCzkl1FawXa5lukhf/dCqGcbFzKA7IvzLBq+vOc7r2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5551.namprd17.prod.outlook.com (2603:10b6:510:b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 17:04:32 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 17:04:32 +0000
Date: Thu, 1 Feb 2024 12:04:25 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sajjan Rao <sajjanr@gmail.com>,
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <ZbvPGV0a3xOMsAMG@memverge.com>
References: <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com>
 <87h6iskuad.fsf@draig.linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6iskuad.fsf@draig.linaro.org>
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: f527609a-4bff-40d9-a0f4-08dc2347dc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WFd3iqGMLEsFq+Msk2H+k5l0tdEwg/ld8nKXI8vTapmzbVzU2dYz2tNZOmWnygonzKf09V3D2JxzZZ2hCoRSlzwkW0DlavW6FhIEZlUefsLKf0lXWIoGQjqcrqlfL9Mc+xRTf8kr4paceGYVK77FsQHqtpW5rHvAo4560DpGIp3ZsBav+xjtOG0HLlPkTafv57G6zDHFfMLRbZRdHGBM/wi34vNSJZS+tYqh7mf5Bnwqba21Jfd9z3v7HYvFg3ujbMWLU5iuSVNxfIBnLFz9KepCsMad41uoF6iF5K6A0hgiMv0DDRL9qoll63JoE5RbmMppRfP5ThVH90qvw8ngXu5b6EWzd2XwV9+ugq6OQpF04evatEbUnnwo99FzIqaMXMF8DL7dyL2jLzIZIv8WlrYW5epWSx3adduBQN6ne5IdmDGi8Uh7RA7obD/isWHwOMtt0OWHE4DF+JdZb8d0Vo1l62yHl7l4CDV/bAHbpDKWs9uKxucFM6pOSMwB0juqzl0vJYXxbbPF6/UTxZvusVmpFNqpeIRmb1b3sHF5eJOJ3FSHDRNRfYw8zyDqRpdl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(66574015)(2906002)(2616005)(41300700001)(38100700002)(6916009)(54906003)(8676002)(8936002)(66946007)(66476007)(66556008)(316002)(5660300002)(4326008)(44832011)(6506007)(6666004)(6512007)(6486002)(478600001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?GmTGCJ8Z1P6+qx2gPIxaQ4NLnDKeZXuxbExD/adMbf2Z/bBjIGiMpgqSZj?=
 =?iso-8859-1?Q?dk7fvcorNDvg6/TKIPahLvKI0sxQxtqV2oQVarxCPBbte4M73HjnrbdWrS?=
 =?iso-8859-1?Q?vfnKxXjsJTOG737E5YbVy9BEIhP4q3f25dHzmhHCbTfItjPy4ZovTNk7KC?=
 =?iso-8859-1?Q?VXUuiZD4gnuQJQOwWVVtpFVyfEQriDLebOiXQM+mS6R/Fc4SER2CIpUt7e?=
 =?iso-8859-1?Q?LTzsugwFKrM9m6dYQ+MFeuBAEA9J0iphtkIUIRaTfk/hORkWtVeCuP8HSq?=
 =?iso-8859-1?Q?5+9HWbJOyRoBo3UpFrriklEGHFkPEi5VC0C9wKBaPhUzrWzD1W9wV1U8H9?=
 =?iso-8859-1?Q?8KHgb3gtJCD2AU6CcHLQ93To8Pl1mntFVApT+vIV0SvFF+E8pFUGGKcriu?=
 =?iso-8859-1?Q?CXWtTIyVj0zxLfl5uurWgytC5HsgJbM1f8/1AQZvludrSMsYyIHnzxZnpS?=
 =?iso-8859-1?Q?6A4xoMefnT8GE9IsREmFur2SAOSVIkNyUcsbLgdqtHe4YROnbvPKRs8Aq+?=
 =?iso-8859-1?Q?lo2SuQHP38PgayxmqlLt9uypnwtqX5PHBtrHNuUvVB3sQlMq/Ep2kkH7Zy?=
 =?iso-8859-1?Q?+hyvaa18dgJXHdYu9oYC7OCo2DjLMjfW/h1Xznl1ncFR0TUnElB5N78Dal?=
 =?iso-8859-1?Q?wJf7cVv8dPferuCk+7xeKpoC2oAZYYU0vF/F/dAMKr5uvbBDt+UKFmXjQT?=
 =?iso-8859-1?Q?hRISc9s9ArL2f9a25VX7c008Elh/jHiVB7fVbk9gypT37lbhgkD/gnNJUt?=
 =?iso-8859-1?Q?5Mnsz/qTc4AazazWu63wdDmXJ5scf6T9ZKOvzdIFRz+K5NfMxmWSrSGzCK?=
 =?iso-8859-1?Q?0DsVlBHYlEe8QRD60ftPMd1GrkT6rNOJ3/q6kYZPe3miB2P2EsDr7tdLH1?=
 =?iso-8859-1?Q?SwPr+5XUdMgforGkXDA67UdBRuP3Hw3gVF6Bh/BfMthQhCKqtbjv0OLywn?=
 =?iso-8859-1?Q?GUQUkr6WPnzKVdQaH4oECw6f9cJzQEWmiqMAqVeWXo9BLmX3gIKj7ZQV/E?=
 =?iso-8859-1?Q?LnR+G6vqOcqEyo/slYpmx6JYgKZ1ETVKQjNdowA6FARwUgnilyMK7JTVxQ?=
 =?iso-8859-1?Q?IoRGtpSFOqvvzKFsvZln5CTcyf0l8qxNNzXtspudp5PiGiqc42g+St9Yb7?=
 =?iso-8859-1?Q?5SbS/UvZUcJzo3MA/8jMHJgGFQSLpG2E9ubB+4GDcWySVMOsvfNsvVguZE?=
 =?iso-8859-1?Q?vb7cXBr4gPwNQf/iJDTiPP7OK74BWgToiV4se21mEZzOOXmz7hK5a4psY8?=
 =?iso-8859-1?Q?CW3lUIb3Bs1ntDBIiHCiPEZ8Ikt8fwatL4j1Q7dny7DbEqOPdyNfVqosnG?=
 =?iso-8859-1?Q?jaGVLKC56pIeJcriWGLLSwllNIzgrpTaiFAR2I98uV4LZgVS3CZF7oopWj?=
 =?iso-8859-1?Q?Xah6K/M+5/f0MPwWnqPOQpRwg58h7yt2H5Q5NcMAW4D6MUu521VjQVp5ST?=
 =?iso-8859-1?Q?v6hdbw+Wn5Vte8m07P1HifjNSj7ELxE1rBNpoSeCQNAIKVs3cjDd/0wZbF?=
 =?iso-8859-1?Q?3vtKzKVgFHj8rnJuL5MTOdjwE2UYA/KTgNzblK86RfAy3RQJVqYXetvvHB?=
 =?iso-8859-1?Q?EFg8JF29KPhBjPSDqcV4Z7atCcPIqh11PJZ021idO8RzW8Cl5wpbkw+NcR?=
 =?iso-8859-1?Q?10FBf5sTWN59nYFIxonFIYaQn/8Vz/+YIYDP9rVgN6pmXbBoYSJGpfDw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f527609a-4bff-40d9-a0f4-08dc2347dc1b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:04:32.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uekkmYYo8Ra5gGN5E/SFSSv+VgJLoVG+MBLi1m13O4XiU3k3Eu7NavrrM4wPeQRBqfNgxzLiClqpsIvrLvJCIkKXH8uuikqAKHYRF2PItPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5551

On Thu, Feb 01, 2024 at 04:45:30PM +0000, Alex Bennée wrote:
> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > On Thu, 1 Feb 2024 16:00:56 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> >> On Thu, 1 Feb 2024 at 15:17, Alex Bennée <alex.bennee@linaro.org> wrote:
> >> >
> >> > Peter Maydell <peter.maydell@linaro.org> writes:  
> >> > > So, that looks like:
> >> > >  * we call cpu_tb_exec(), which executes some generated code
> >> > >  * that generated code calls the lookup_tb_ptr helper to see
> >> > >    if we have a generated TB already for the address we're going
> >> > >    to execute next
> >> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> >> > >    address for the guest address
> >> > >  * this results in a TLB walk for an instruction fetch
> >> > >  * the page table descriptor load is to IO memory
> >> > >  * io_prepare assumes it needs to do a TLB recompile, because
> >> > >    can_do_io is clear
> >> > >
> >> > > I am not surprised that the corner case of "the guest put its
> >> > > page tables in an MMIO device" has not yet come up :-)
> >> > >
> >> > > I'm really not sure how the icount handling should interact
> >> > > with that...  
> >> >
> >> > Its not just icount - we need to handle it for all modes now. That said
> >> > seeing as we are at the end of a block shouldn't can_do_io be set?  
> >> 
> >> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
> >> which happens earlier than the tb_stop callback (it can
> >> happen in the trans function for branch etc insns, for
> >> example).
> >> 
> >> I think it should be OK to clear can_do_io at the start
> >> of the lookup_tb_ptr helper, something like:
> >> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> >> index 977576ca143..7818537f318 100644
> >> --- a/accel/tcg/cpu-exec.c
> >> +++ b/accel/tcg/cpu-exec.c
> >> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
> >>      uint64_t cs_base;
> >>      uint32_t flags, cflags;
> >> 
> >> +    /*
> >> +     * By definition we've just finished a TB, so I/O is OK.
> >> +     * Avoid the possibility of calling cpu_io_recompile() if
> >> +     * a page table walk triggered by tb_lookup() calling
> >> +     * probe_access_internal() happens to touch an MMIO device.
> >> +     * The next TB, if we chain to it, will clear the flag again.
> >> +     */
> >> +    cpu->neg.can_do_io = true;
> >> +
> >>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> >> 
> >>      cflags = curr_cflags(cpu);
> >> 
> >> -- PMM
> >
> > No joy.  Seems like a very similar backtrace.
> >
> > Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
> > [Switching to Thread 0x7ffff4efe6c0 (LWP 23937)]
> > __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> > 44      ./nptl/pthread_kill.c: No such file or directory.
> > (gdb) bt
> > #0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> > #1  __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> > #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
> > #3  0x00007ffff77c43b6 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> > #5  0x0000555555c4d19e in cpu_abort (cpu=cpu@entry=0x5555578e0cb0, fmt=fmt@entry=0x555556048ee8 "cpu_io_recompile: could not find TB for pc=%p") at ../../cpu-target.c:373
> > #6  0x0000555555c9cb25 in cpu_io_recompile (cpu=cpu@entry=0x5555578e0cb0, retaddr=retaddr@entry=0) at ../../accel/tcg/translate-all.c:611
> > #7  0x0000555555c9f744 in io_prepare (retaddr=0, addr=19595790664, attrs=..., xlat=<optimized out>, cpu=0x5555578e0cb0, out_offset=<synthetic pointer>) at ../../accel/tcg/cputlb.c:1339
> > #8  do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012890, ret_be=ret_be@entry=0, addr=19595790664, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
> > #9  0x0000555555ca0ecd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efcdd0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
> > #10 0x0000555555ca332f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595790664, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> > #11 0x0000555555ca5e69 in cpu_ldq_mmu (ra=0, oi=52, addr=19595790664, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> > #12 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595790664, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
> > #13 0x0000555555b4b5de in ptw_ldq (in=0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/excp_helper.c:98
> > #14 ptw_ldq (in=0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/excp_helper.c:93
> > #15 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efcfd0, out=0x7ffff4efcfa0, err=err@entry=0x7ffff4efcfb0) at ../../target/i386/tcg/sysemu/excp_helper.c:173
> > #16 0x0000555555b4c3f3 in get_physical_address (err=0x7ffff4efcfb0, out=0x7ffff4efcfa0, mmu_idx=0, access_type=MMU_DATA_STORE, addr=18386491786698339392, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:578
> > #17 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18386491786698339392, size=<optimized out>, access_type=MMU_DATA_STORE, mmu_idx=0, probe=<optimized out>, retaddr=140736029817822) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> > #18 0x0000555555ca0df9 in tlb_fill (retaddr=140736029817822, mmu_idx=0, access_type=MMU_DATA_STORE, size=<optimized out>, addr=18386491786698339392, cpu=0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1315
> > #19 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd120, mmu_idx=0, access_type=access_type@entry=MMU_DATA_STORE, ra=ra@entry=140736029817822) at ../../accel/tcg/cputlb.c:1713
> > #20 0x0000555555ca2b71 in mmu_lookup (cpu=0x5555578e0cb0, addr=18386491786698339392, oi=<optimized out>, ra=140736029817822, type=MMU_DATA_STORE, l=0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1803
> > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=0x5555578e0cb0, addr=23937, val=18386491784638059520, oi=6, ra=140736029817822) at ../../accel/tcg/cputlb.c:2853
> > #22 0x00007fffa9107c63 in code_gen_buffer ()
> 
> No thats different - we are actually writing to the MMIO region here.
> But the fact we hit cpu_abort because we can't find the TB we are
> executing is a little problematic.
> 
> Does ra properly point to the code buffer here?
> 

What if the code block is ALSO in CXL (MMIO)? :D

tb_gen_code():

531     /*
532      * If the TB is not associated with a physical RAM page then it must be
533      * a temporary one-insn TB, and we have nothing left to do. Return early
534      * before attempting to link to other TBs or add to the lookup table.
535      */
536     if (tb_page_addr0(tb) == -1) {
537         assert_no_pages_locked();
538         return tb;
539     }
540
541     /*
542      * Insert TB into the corresponding region tree before publishing it
543      * through QHT. Otherwise rewinding happened in the TB might fail to
544      * lookup itself using host PC.
545      */
546     tcg_tb_insert(tb);


> > #23 0x0000555555c9395b in cpu_tb_exec (cpu=cpu@entry=0x5555578e0cb0, itb=itb@entry=0x7fffa9107980 <code_gen_buffer+17856851>, tb_exit=tb_exit@entry=0x7ffff4efd718) at ../../accel/tcg/cpu-exec.c:442
> > #24 0x0000555555c93ec0 in cpu_loop_exec_tb (tb_exit=0x7ffff4efd718, last_tb=<synthetic pointer>, pc=<optimized out>, tb=0x7fffa9107980 <code_gen_buffer+17856851>, cpu=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:897
> > #25 cpu_exec_loop (cpu=cpu@entry=0x5555578e0cb0, sc=sc@entry=0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1012
> > #26 0x0000555555c946d1 in cpu_exec_setjmp (cpu=cpu@entry=0x5555578e0cb0, sc=sc@entry=0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
> > #27 0x0000555555c94ebc in cpu_exec (cpu=cpu@entry=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:1055
> > #28 0x0000555555cb8f53 in tcg_cpu_exec (cpu=cpu@entry=0x5555578e0cb0) at ../../accel/tcg/tcg-accel-ops.c:76
> > #29 0x0000555555cb90b0 in mttcg_cpu_thread_fn (arg=arg@entry=0x5555578e0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
> > #30 0x0000555555e57180 in qemu_thread_start (args=0x555557956000) at ../../util/qemu-thread-posix.c:541
> > #31 0x00007ffff78176ba in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:444
> > #32 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
