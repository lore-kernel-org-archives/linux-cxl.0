Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724A41757
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813785; cv=fail; b=JuwEL9oKAO0P4iSMoG0jFU5TMtySgJr7ZplwwbprIQZUv4X52izU1Er9bHbkHjC3dwGSboF33a/+bTNqYY7TYPjTI0mLWGEdELPJE3NX4FuCIfe7yHw7c476EjoT7AKxcyxMdOiz5yHnDv8ExXnkqd++er4SqimxYJtzeo69F7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813785; c=relaxed/simple;
	bh=AcC0XYhNXRsBz0LBBWaQHW5Ug3/tC9N/QeMu4/Ij9JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XgfZOSNf/ikjA8t/s4koNfFxFNaZkZif+y8t/G8qk8u1DJhSIQkw2xnPAf+IpJdUqVdn8664ia2z79qDgauzrfU0n8Z+V0FuSHmM/HQJE8o13d4lV7AHMuIhsv9+sI6DfXPK+lCBLPI26NtnknRGE3DYHqp9J/0lUzLBW2WYofY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=fail (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=rhL9zjEN reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="rhL9zjEN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO2ZNh7Xapk9+JJv0iIw2uhma0L24phYyZxZ++nB0UHaPe27RJW8H/fZ7EVmhNMMDrbgzzau307wHyHinV6Fg58nCe7+fTbhi3ppmNM2ZStruK3IAnxbzjSMgTjJOZXP0ZUTjfXsq01kEOuhcoZ7gsPNIn8M2AFj7sBsFmsIrUQtnhFTDBS27xaXUMfFjkAV2HbBlbwR2F9scsUuhHCSytFQP/OsIbZ3v2X0qINeRapofgA0l7HQvBJllifYCNemybV2cNIVwFQV+16EUNqQtMXi4LbUxNfUgJWc9fZxrkIA+Jx1uuszUvyUi5daki+8NblqEfmbcML7b050kgGFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj3RLAxQo/9djh5Q9wqud9APxGYPxavymNQ4Jzzj7Ow=;
 b=Bz5GZauEjkNi+93F1+Je/2fNRQuaaEevucqLe4YeUs8y5Nr7vApxaYtYqMYr9L9xvndamXp6OrIlzWH0cK7YCTRlN9rNaHYJq/UzZxAWKWQZH8fIaDNmMh4Kiuqq8piZ2cqBRETZrJ2DaXsIArcwCLWWOYsG2hmho7xm2xHH232MSfXSpJdwh0/svXfuHw3ogKjzBYAaKUnsqDY60OzVJse/M1M42AD1/vI2kRHhUZExt7dTqozc23XkwkJbZ4hVHBj+rS7sLGs7S0PQretga28mQu12S8fLSa3Vi77zRf2SaKDktjfbD2fdAy+i73v6v7iLTHN9PaAW55YuzCjsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj3RLAxQo/9djh5Q9wqud9APxGYPxavymNQ4Jzzj7Ow=;
 b=rhL9zjENyVYHCfGKfIjbNDxP8g0IvOmhreVtmgjVH8Y/0bTwOj+cItJwOE2AaL7O1005MTvdBSAtoXHZpQ8cST+GDXMmAnNglexdbO4gmrSq4z6UpLlZNxj//jqpytNR2TSMk8BTbSmazS8ykVmXpqSM7/dfFLe2QfjsbXymfP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB5874.namprd17.prod.outlook.com (2603:10b6:8:43::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 18:56:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 18:56:17 +0000
Date: Thu, 1 Feb 2024 13:56:09 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sajjan Rao <sajjanr@gmail.com>,
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <ZbvpSaOXzZkqDd6c@memverge.com>
References: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com>
 <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com>
 <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: d7103bf0-f079-427c-b27e-08dc235778a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AFkgh22sYiue2S90ZOpklpQlc6yXmZu6wlDn7RNOAHPGqI6MvOxIxd4NnopLSoF5PQL7Q5k/0KvEEikGu+3d8grb0LEpV0ySFMgPyu2yCWkgQTOxsY1ADBNEn52A6x9BJjEZ4i9wVStiseh191KxtgiUZwcLldSiN1NZfbA9crgcKrEMQoqBB9m0jg6tvwRKzbgMPXpkQ82OxzPGJDcU80H4oD//u1bnnmNWmvuSE4ZdcV5rGfWCMiWo3RRQ8v9PglkrUfvPAuPDA1EU2gSa0IKlDi4mpyo6ihlr+LKksxHm/LOu0qRrbO68V2ymSNVRyX0AJMuO3ZGWR5lGLZBMupziRkomf513nIGcD9xDubUYenSvty0L1/S6QGsEmMUQpERZvs1YcnUM3iqUDWIY9Zmxot24CTRglbHXYqTj6oR+s4W85Tl1syevboIeWWTMSjDfCD9y47ZCI0yRPdmtI1TaB+Sdx0GrxOusQaAk4tUN5gyrkVWH1BxdK9WQQU2+ETIwQfxuFLlnDkmkqXH04jCwdiVb98R177FV3vR+j70LpuPUo5RhdTQtOLBYpENo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(36756003)(86362001)(41300700001)(66574015)(26005)(38100700002)(2616005)(6512007)(6506007)(6486002)(2906002)(478600001)(6916009)(66946007)(66556008)(66476007)(316002)(6666004)(54906003)(4326008)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?nBu/3uDFc9JgsmYUCPOCVMJnJuW21HpwCZeo6RI7hkcARs8Xl2wdWJbDft?=
 =?iso-8859-1?Q?P9UUsVqxxkbJdcjxciNXm8HF+b33ZWojR+6RMbxYiQiWZQK3dAXCQsQrCg?=
 =?iso-8859-1?Q?e1g3jjKYzQ8vanPjVPtHE2UyzCspB4gjPEyNU3Pu3ffYkMu0bN9oeUQ39Z?=
 =?iso-8859-1?Q?6F0j6wERelh9cmGMM5HB9Cc4Pql+TfcgBtbNB1GD8xsuiA55y1crgytY8v?=
 =?iso-8859-1?Q?rrq9ChnUxVf/cnCVxk4keGtAVfE7RG//Wn3ADt2sBGb0IpXqk4lk6usWSz?=
 =?iso-8859-1?Q?5QUHHPqO0o5ES4UrzEN0K/Jz6gWaj4mMHjFUqQEjC8YROjVwKZad8QYb1U?=
 =?iso-8859-1?Q?DhMNDd4eluLPH98+S0y+yEMLpivWoJ2Of5ZNEEaJD/s6fjDOObGrGeZPxC?=
 =?iso-8859-1?Q?daGSCQlL1SzJG/aPNpLkZJ7tLlrLq9Var4lI7A1fj8HDOtR2LbD/QJgmwr?=
 =?iso-8859-1?Q?NnmYHI1IDGUGHqTbUdPupkF6DBxAOyIsCXcXMLPsT+Otu2RtBbrcnsqvwe?=
 =?iso-8859-1?Q?B+FLAuAgAmP5dManDfOP2MOxaI/ObWagfPNuWAhW+NSMPrlmZR3W35U6rf?=
 =?iso-8859-1?Q?UDVo+viyX1clJj4ZcGFHNvZMwlx6+Q0QUXtJB0Ird/FeYZ5Wk+rY53APyj?=
 =?iso-8859-1?Q?hHiuK6eIBxAwr1jkJl7E24i4rCewiYJKUKccCUyPx8thV7v4jxK4DMsoq1?=
 =?iso-8859-1?Q?cigW001/OGZ2jfSk/kwmNFXZxHt+J1XR1x4ZxFd2QgX/1pnqivdECVWRZY?=
 =?iso-8859-1?Q?XPNrgsX3dXLnv9096j1xtPntV0cnX4JTS1U/q/8hUwyIU89L+p1ouw2Fby?=
 =?iso-8859-1?Q?EfyCp+hM6WCO9I/8baEhDkNfAR969EfU5KLYTRxbwRl5L0BYIEaXSgtNT4?=
 =?iso-8859-1?Q?n2iTjdwYY3h5DNHg2kBIpqWu5VR6LM0S5vdE9vJGd+m+y3X9WmnC6vXurB?=
 =?iso-8859-1?Q?ixGIDMJInWxepzA4rKsM0AiZ6DGtOPpr+H3cjKwBlsEAdPViXkyt2lUDRB?=
 =?iso-8859-1?Q?ToKft5rV0K6svi+akizjiJWofD+uVYrK2jiSClEtmdaBiVzIyurXyaa4iZ?=
 =?iso-8859-1?Q?BDQmM+P0Xt80oRXdyrIjA2eUYP55EPuRER5D9fQLPrrrSK3F7dKmm5VuDt?=
 =?iso-8859-1?Q?SQi6Pg/WR2uYr3lqtVDSWCDMD6eBpk1CnwH8Hra3iFRz39O2UC410cHFSS?=
 =?iso-8859-1?Q?te0KeKOqsoHtoIL+hHG/Sp82IjxoWvTPvDbacQfJSgn8+JqoWY6BZMFHxf?=
 =?iso-8859-1?Q?MKhZulva95j4GZJ726W2ZBva9ZBXJjmmO7GRyRtm719O6rRdBydpboYtlj?=
 =?iso-8859-1?Q?WiMo/H0ZPMux1jACDPgNS21YDSM4iAQ9wL1mku+ag2FY1zc29rU/boFRh+?=
 =?iso-8859-1?Q?Lr9gFpcxk77pKtjoWc6ChMqX/fPsW81kXCSpKghlpNL5qRJPK3e41GQkKe?=
 =?iso-8859-1?Q?2EFgG/KDnMP1yk+irXIFmBTYz6T6grqZv1HL86V27YLWM8nSVU6R5lYLg4?=
 =?iso-8859-1?Q?DGkJYTpZ1qhOQAjfm0MeIxyDBl6Y6SsI/iyLWe2Pt9fr6+Jer+GFAcLIu1?=
 =?iso-8859-1?Q?pbSdMClpdtmfKdIBOHYjq+dP5UvTSZGc1WqSSoBnSNtnQl5RBO8CsMacl9?=
 =?iso-8859-1?Q?KlWhzOhTi1iWG5M5SEm1nY9Vyd4ZmffJmzUq3bhlhnUi8PhqPqRIk4mA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7103bf0-f079-427c-b27e-08dc235778a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:56:17.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LLUl8IZhzJlcnkDWPfgmiMR3KVcEKDIxGo+OFexH2LwNsd7HLwTKadwuCGzFHsKzHFR+0pW4t51wl8w0gGQEzVR9LrNEbkCbfk30EFa/x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5874

On Thu, Feb 01, 2024 at 06:04:26PM +0000, Peter Maydell wrote:
> On Thu, 1 Feb 2024 at 17:25, Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> > >> > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=0x5555578e0cb0, addr=23937, val=18386491784638059520, oi=6, ra=140736029817822) at ../../accel/tcg/cputlb.c:2853
> > >> > #22 0x00007fffa9107c63 in code_gen_buffer ()
> > >>
> > >> No thats different - we are actually writing to the MMIO region here.
> > >> But the fact we hit cpu_abort because we can't find the TB we are
> > >> executing is a little problematic.
> > >>
> > >> Does ra properly point to the code buffer here?
> > >
> > > Err.  How would I tell?
> >
> > (gdb) p/x 140736029817822
> > $1 = 0x7fffa9107bde
> >
> > seems off because code_gen_buffer starts at 0x00007fffa9107c63
> 
> The code_gen_buffer doesn't *start* at 0x00007fffa9107c63 --
> that is our return address into it, which is to say it's just
> after the call insn to the do_st8_mmu helper. The 'ra' argument
> to the helper function is going to be a number slightly lower
> than that, because it points within the main lump of generated
> code for the TB, whereas the helper call is done as part of
> an out-of-line lump of common code at the end of the TB.
> 
> The 'ra' here is fine -- the problem is that we don't
> pass it all the way down the callstack and instead end
> up using 0 as a 'ra' within the ptw code.
> 
> -- PMM

Is there any particular reason not to, as below?
~Gregory


diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439ad..2f581b9bfb 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -59,14 +59,14 @@ typedef struct PTETranslate {
     hwaddr gaddr;
 } PTETranslate;

-static bool ptw_translate(PTETranslate *inout, hwaddr addr)
+static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
     CPUTLBEntryFull *full;
     int flags;

     inout->gaddr = addr;
     flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, 0);
+                              inout->ptw_idx, true, &inout->haddr, &full, ra);

     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -82,20 +82,20 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr)
     return true;
 }

-static inline uint32_t ptw_ldl(const PTETranslate *in)
+static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldl_p(in->haddr);
     }
-    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }

-static inline uint64_t ptw_ldq(const PTETranslate *in)
+static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldq_p(in->haddr);
     }
-    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }

 /*
@@ -132,7 +132,8 @@ static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
 }

 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
-                          TranslateResult *out, TranslateFault *err)
+                          TranslateResult *out, TranslateFault *err,
+                          uint64_t ra)
 {
     const int32_t a20_mask = x86_get_a20_mask(env);
     const target_ulong addr = in->addr;
@@ -166,11 +167,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                  */
                 pte_addr = ((in->cr3 & ~0xfff) +
                             (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                if (!ptw_translate(&pte_trans, pte_addr)) {
+                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                     return false;
                 }
             restart_5:
-                pte = ptw_ldq(&pte_trans);
+                pte = ptw_ldq(&pte_trans, ra);
                 if (!(pte & PG_PRESENT_MASK)) {
                     goto do_fault;
                 }
@@ -191,11 +192,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              */
             pte_addr = ((pte & PG_ADDRESS_MASK) +
                         (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_4:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -212,11 +213,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              */
             pte_addr = ((pte & PG_ADDRESS_MASK) +
                         (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_3_lma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -239,12 +240,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
             rsvd_mask |= PG_HI_USER_MASK;
         restart_3_nolma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -262,11 +263,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          */
         pte_addr = ((pte & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_pae:
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -289,10 +290,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          */
         pte_addr = ((pte & PG_ADDRESS_MASK) +
                     (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -307,11 +308,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_nopae:
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -336,10 +337,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = ((pte & ~0xfffu) + ((addr >> 10) & 0xffc)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -529,7 +530,8 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,

 static bool get_physical_address(CPUX86State *env, vaddr addr,
                                  MMUAccessType access_type, int mmu_idx,
-                                 TranslateResult *out, TranslateFault *err)
+                                 TranslateResult *out, TranslateFault *err,
+                                 uint64_t ra)
 {
     TranslateParams in;
     bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
@@ -548,7 +550,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             in.mmu_idx = MMU_USER_IDX;
             in.ptw_idx = MMU_PHYS_IDX;

-            if (!mmu_translate(env, &in, out, err)) {
+            if (!mmu_translate(env, &in, out, err, ra)) {
                 err->stage2 = S2_GPA;
                 return false;
             }
@@ -575,7 +577,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                     return false;
                 }
             }
-            return mmu_translate(env, &in, out, err);
+            return mmu_translate(env, &in, out, err, ra);
         }
         break;
     }
@@ -601,7 +603,7 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     TranslateResult out;
     TranslateFault err;

-    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err)) {
+    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err, retaddr)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
