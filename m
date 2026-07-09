Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0834104B;
	Thu,  9 Jul 2026 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564450; cv=fail; b=Ducdg74tAqDpwee9xR52/CAiN3rmA65C6VMJmKB3HM6nmiAwSVBpHUkuakhWeOGjy7O8zLyEk9ipIEq2WnwOrpLSTK7/9dvk+RDbqgfX165RWz72gzO6mPg3sE5Bpx/FPcK3tgNV7NFg09YPCcHIJ9PkfALr9cm/VUt41I4CbZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564450; c=relaxed/simple;
	bh=IiVWpsvabs5DKFNxVrScGmC3pv1KWvpgz/9jlRkzy50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A9hEMDbLy9XNp424pzkP3SPstbzFC0oiiZVHChHsWq0MTZXGyFnBEcZ6SvIW+J7R39NtNfTu0+8SvkjmXqZqrUeO4UxpXcIoKYLP3w+RTuLSMn152gfvpBuUFjRvJwIDJYaoeLM8Gx02WEAhkWpsBAgm4z1YYpy5TEnzFfkybiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHvFAxcj; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHvFAxcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ekk9ZtTzEtiQnonW7bbtkbttprHD+2b98dPvusX4Y5CTesyzc/8n2VJAKZ5RTpu19M7coBm36jaQB+4P0gy9uj+PpoSsWPmNkCxS0kfB8EoNhfHy20jE34FKw/4+RccFivph+vHVtiHRo5HNfEQalmxcUxQ5TvU5fWTqpgnrSBl3HIms1MQ4OLs0fEwoGOBGz6lr1lp9wYLt0na7fQRshSNOwjr8Gc59+dj1vX9vWPfu3Wh/L6G1cwAtdBsquhgxvEz/GyPpZeK7vTiQSblFgKUtyM4rLwylzIvhzaSpy+5EqbbLEqiT0uFySuYANndMAugirCcuF6G/1QsId2K8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM1/wqBVfPQ+6XE3A/MWdwaS0YSnm7iWnH1CoHXpkVQ=;
 b=QQom6/u8ZpmajG1Rl6ASPqX93wVCyjt8x6P3BTsh2P3LlSveLFZ2rvATMjzzwh+bPhikCPez3Dc5lQnqJk5w4ZuLTQqNwGa3Ukoc4003sFuJ+DrKo90jt7wLYkcrn4Qwm08P3akAZgw4H13kdRTWlLwvh8Q0vje0M3g0YzAnnie3/pENVS7CTsG0F7y0bTzi7LMB1I9d2cLkIegqvkM4ZZ2jKg/n4pHHhSF3S4M83wTNoxIjBuObmK/9KeBLBB4mzY2n8RnPoptHiku5CD8Ada7X+Ber6c/WfDfXsW2K/kQaAsWyph3E5cgyDKIoY2+Da2CMWwG4RQJe/glVzk2hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM1/wqBVfPQ+6XE3A/MWdwaS0YSnm7iWnH1CoHXpkVQ=;
 b=hHvFAxcjq4QAwREAZPK9S1ym2ckDn+DIsRIAbYC95BbjOOdbFeX0O68Yqu4OWuixzKKJYvHyWK4ZQOz/YOLhkLiZtANZuMEjF/3NmPmrn/NvYkcSN630QbFMUewLA2U2aMuKlE3nqJJLlkoH2bafwnecBiJZeDlIXZrVMVSOyvLmAQLCEmlhR8Hvb9ZzUSi+64U2wGyzndmheUqKWVMX2K3sawEzwlZM7n8R8xaV2UF+nXJnMZ0pSDKLlTT6ljTOfRycdtnhLlKdPrPkMSZHuu9b4dSD5Bv3wjabSLihQ0s/O3AhZh0QaiRZbxlifxbmmvOfP4Y2kK8rihrxarVsBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 02:34:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:34:01 +0000
Date: Thu, 9 Jul 2026 10:33:58 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, kobak@nvidia.com, kaihengf@nvidia.com, kees@kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
Message-ID: <ak8IToSEEfinDgWl@MWDK4CY14F>
References: <20260708104024.68029-1-icheng@nvidia.com>
 <20260708104024.68029-3-icheng@nvidia.com>
 <ak6Yi55kRbX4tCl3@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6Yi55kRbX4tCl3@aschofie-mobl2.lan>
X-ClientProxiedBy: TPYP295CA0005.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 91aac00c-606f-4f73-f989-08dedd628958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2VUQKiToCY5f9vjC1Qq6TT68jMnaGygljLxJ5PaA2vv8fkAbJcfH01VH0rGvxq4YbAtp94o4R1YBZ+IrpbGphuZ8AAHHmy8qDxPr4zj5dR4QT4qI8W+Ul1FVyH4nuUWYma+8ZZ3Mnpm/eeuhVbWktBkdEoab7vFnvdhPyaWipyMnAP0sugFGeLzbaDeLo/vDIuffo0RdGjDnp6wbhGBh/rYLL3rNL9r8kPrP9Lcx9BwrTyVoSWffrEnP41jz45SCAMvsnQpGWQKJXRbdSBn1WTJX6kzpdEs7eU3KjviwQhkyhi/vPhBNtjnX8y4QgXB6AnkJvIHlGpq1PT1R1GQzGIl2lmKqX8Z/w3LLwmxU4YaMkSkdmbRw0Mq1CSg9k3y9ZYFrdh05/hCUexoLiCMtUGn7Zx4kuHuusordrtoF/k47ImA7/0BlJTYF0mxkh6RlNikmk73RQBDg+zVEOBsx+qqlHp9DO6idkmP+mCFKaJH4fIbB4HmZNLuISrB+og82CKsfvSfT0YoDLdTKDZ0GokzPhXJ/Cyo/978yRF5r4PGe6jZuxtU7mcVLT1Gr5t0iuKcuqhcfV6/z4V8Kig6LojyaNyBgApTgiu7tr8QF5rcnN57lCPwzn23hYVq8ZTz7rSb7J7XepKoHeoLpLfHPcyMFYtB0C4iS8YKHG0tZKwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vOc1W3mIJqrKIIinZ31TfQt9XeQFb8O5Xg9EfxKxhdUlcjvZUf+BhJxroDqN?=
 =?us-ascii?Q?oetCzhl9ycA/O4ILnNRjK4IKh94YbAKzyREdkmQWsrSvHuElRvmim7qu6Du+?=
 =?us-ascii?Q?HA95L15tPCIXV9hl4bIdbG/W2UzqJrOwf3Ou0TJA9g+42KuPmcVsRkW4WNv+?=
 =?us-ascii?Q?TQ/NwdjnQLqgLHq3TpHH2P7D5u2irTS9srNvPdhg+tugdI6UoeFGCBRj+b24?=
 =?us-ascii?Q?rd/3I5qQQKf4kmpilqP9WgVLBV4IdOG+h/i52jj+S8a4HGOJsOfjKk3Fpk+E?=
 =?us-ascii?Q?zzbtyrwKxOGzZWO0c5lZq/1IjSy+4Y1Ym4/dxk1K+jMEk78LHueLrumpZYy8?=
 =?us-ascii?Q?T50GpqWorsEPt8gJiGE0sncPTDDk/W4oUh1vubjDkK6wNfQoVY0an65To5s7?=
 =?us-ascii?Q?VgVGvTfkzhsK6+D5COPUVvSdywq+GRmfnQJs7Da5IDUx21wmBHiTHsWhLDMj?=
 =?us-ascii?Q?2sih4nLA8NfZoEOYiSB4/lKvEQzlIkgwc8rMY57/WJxQ4xpjyWFgGWPAp0hG?=
 =?us-ascii?Q?ebKDPvFG2aBD3z+eoyeeoYTwh1r3utcudY3IpmaRMysoom2i5vu0fAw6IcPt?=
 =?us-ascii?Q?2Q73gBR61QukGR44FI3/NT00+RmLm6rhZNyczru5+q2W6eIsJOqy/L2+edp8?=
 =?us-ascii?Q?nClNsJgbSJTyX9ge4qw95jOC0SUdDpp7Cc8BN8W6KaB1QGIj+Jlq9rZeWZX+?=
 =?us-ascii?Q?sM4CG3YrhwlmEgeRVMOt2e/gN3n2w4X+T9JCewDJWipwgzWKOBwlUCglewQ1?=
 =?us-ascii?Q?Wo611EYBOJ2CDTqovRRv11krm2X5nFkcE3gA6VUkJ4okSAfAWZCJs7Kby6gO?=
 =?us-ascii?Q?U74WYmdwrKSWSQziiPMlmnwKFuyLo9YUxOn2uY0roPo72AOwbD05JtdzDRIG?=
 =?us-ascii?Q?zKw4KiVEvaHUT5qhH7A0LF42LyLqzCpZLmzNd+tsC1eJCLR1T7jKnnoSNWtV?=
 =?us-ascii?Q?tXpgdUJupxn93G35NW35haXJhkQeowX7h3lduqDHDbraKCfspIy/2iusPAWa?=
 =?us-ascii?Q?A7LtZKp2236nx9CuN/A3pEsWX8x4I14w9p6pALXA5lZ+r1Hbx0N3O4IJMLP9?=
 =?us-ascii?Q?Cu58CQkZmAS6xu3Qa8LZgBh/pXi7X5E1VYhmwnupUjFsuIoy9EJ7OdU8g9t/?=
 =?us-ascii?Q?MFJuHTGrokI3Yw6kDMCC68s0hM30gPdoIZkwx9FFfbABKBPP7YUr+fgWW8Sg?=
 =?us-ascii?Q?3cvDU3pMgBeONSmPGZX0hGLIfFspAgKSx6A0flD4e+6hHF4COvf6P5F8bUvt?=
 =?us-ascii?Q?P/qipC0FbhZVV1L2kIroPjBuBEJTXNlmBgprCV0to8EPU+JG+yiDlZ/fIRyV?=
 =?us-ascii?Q?OFi+n/5UzMil0QktqZ/BH4rZX2ZA7Jby2F6ApQmZN/PGWe5ROT8qM5eP5apQ?=
 =?us-ascii?Q?ojIgPwuFQPBw4Xc1l+6NUBplIUn/+PhE4paig6Bgj7OOj/Q4q7CVjTMrYh2s?=
 =?us-ascii?Q?cqZ7hQkrjbmkQ9iBEYOZv8zbVfzJ4NMT633qaABb5oOxv935yoCpZdu0hhhF?=
 =?us-ascii?Q?+dH24wzSI9dEfVA0h6XA7TWEZUhV40388Q5RQWkCMDPlmQF4bC2iublAXsPd?=
 =?us-ascii?Q?gpRLIvWQp2zaTuQCvYInfAnR+P4bIp9JBvO5E4kyxTzCQMINztIQtpaRXhW/?=
 =?us-ascii?Q?nSIbZqtXy4iGnkgmGzItl624CaLiYbg3NET/MsK18DzSYYU8pWQK/1mgVvMG?=
 =?us-ascii?Q?XcPjgLLksE2A1k76UcBxzgOBvKY5fWztpF+l3i83G4tusLUQ85OfuY69eRzK?=
 =?us-ascii?Q?SRq0p5YvKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91aac00c-606f-4f73-f989-08dedd628958
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:34:01.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3UI7GSHgEnlO9aTefaYj/10EvRHzl6CYQ4hlnYE/axHfCrvxDKJFvbUu846mL26OSQd5NcogbPuLcU5Qoos+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD

On Wed, Jul 08, 2026 at 11:35:55AM +0800, Alison Schofield wrote:
> On Wed, Jul 08, 2026 at 06:40:23PM +0800, Richard Cheng wrote:
> > The kernel now allows committed zero-size HDM decoders so BIOS can lock
> > empty decoders; cxl_test needs to exercise that path.
> > 
> > Add a mock_zero_size_decoders module parameter (default off). When set,
> > the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
> > commit decoders 1 and 2 as zero-size + locked above the decoder[0]
> > auto-region, mirrored on the parent switch and host bridge. The mocks
> > take a real zero-size DPA reservation, like enumeration of real
> > hardware, so commit_end lands on a zero-size decoder and the
> > reservation, poison-by-endpoint, and teardown paths all run.
> 
> At v5 review we chatted about a unit test for this.
> Not sure what has happened since wrt the poison tail mappings, but
> the check in cxl-topology.sh 'wants' to be in place to merge this.
> 
> https://lore.kernel.org/linux-cxl/ajozhDmPogKi9hb5@MWDK4CY14F/
> 
> -- Alison
>

Hi Alison,

Sorry I forgot about that,

Just have the work sent out here.

https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/

Does this match what you expect ?

--Richard
 
> 
> > 
> > Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
> > 
> > v6->v7:
> >     - Rebase onto cxl/for-7.3/cxl-type2-test.
> > 	- Integrate mock_zero_size_decoders with special-topology parameter
> > 	  validation and reject its incompatible use with fail_autoassemble.
> > 
> > v5->v6:
> >      - Reword a mock comment, no functional change.
> > v4->v5:
> >       - Mirror the v5 core semantics: mock zero-size decoders take a real
> >         zero-size DPA reservation via devm_cxl_dpa_reserve() so
> >         dpa_res/hdm_end/cxled->part match real hardware enumeration and
> >         the poison-by-endpoint walk reaches commit_end.
> >       - Set cxled->state = CXL_DECODER_STATE_AUTO to match
> >         init_hdm_decoder()'s fall-through (undoes the v2 switch to
> >         MANUAL).
> >       - cxld_registry_restore(): reserve unconditionally for enabled
> >         endpoint decoders; enabled now implies reserved, sized or not.
> > 
> > v3->v4:
> >      - No change.
> > 
> > v2->v3:
> >       - Gate the zero-size + locked decoder injection behind a new
> >         mock_zero_size_decoders module parameter (default off). v2
> >         applied it unconditionally on the host-bridge0 auto-region
> >         endpoints, which the region test suite reuses, regressing 7 of
> >         17 cxl unit tests; defaulting off leaves the shared topology
> >         untouched.
> > 
> > v1->v2:
> >       - Replace second_decoder(), third_decoder() with a single
> >         match_decoder_by_index() helper, so all lookups share one
> >         matcher.
> >       - Use DEFINE_RANGE() for the empty range instead of an open-coded
> >         struct.
> >       - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than
> >         STATE_AUTO.
> >       - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model
> >         the BIOS-burns-slots case.
> > ---
> >  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 94 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 8ab2ce1262f3..fff2004a08c8 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -18,6 +18,7 @@ static int interleave_arithmetic;
> >  static bool extended_linear_cache;
> >  static bool fail_autoassemble;
> >  static bool type2_test;
> > +static bool mock_zero_size_decoders;
> >  
> >  #define FAKE_QTG_ID	42
> >  
> > @@ -872,14 +873,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
> >  		cxld_copy(cxld, &td->cxled.cxld);
> >  		cxled->state = td->cxled.state;
> >  		cxled->skip = td->cxled.skip;
> > -		if (range_len(&td->dpa_range)) {
> > -			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> > -						  range_len(&td->dpa_range),
> > -						  td->cxled.skip);
> > -			if (rc) {
> > -				init_disabled_mock_decoder(cxld);
> > -				return rc;
> > -			}
> > +		/* enabled endpoint decoders hold a reservation, sized or not */
> > +		rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> > +					  range_len(&td->dpa_range),
> > +					  td->cxled.skip);
> > +		if (rc) {
> > +			init_disabled_mock_decoder(cxld);
> > +			return rc;
> >  		}
> >  		port->commit_end = cxld->id;
> >  	}
> > @@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
> >  	WARN_ON_ONCE(!cxld_registry_new(cxld));
> >  }
> >  
> > -static int first_decoder(struct device *dev, const void *data)
> > +static int match_decoder_by_index(struct device *dev, const void *data)
> >  {
> > +	int target_id = *(const int *)data;
> >  	struct cxl_decoder *cxld;
> >  
> >  	if (!is_switch_decoder(dev))
> >  		return 0;
> >  	cxld = to_cxl_decoder(dev);
> > -	if (cxld->id == 0)
> > -		return 1;
> > -	return 0;
> > +	return cxld->id == target_id;
> > +}
> > +
> > +/*
> > + * Mock a committed, locked, empty decoder
> > + * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
> > + * param so the default cxl_test topology, shared by the region test
> > + * suite, is left undisturbed.
> > + */
> > +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> > +{
> > +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > +
> > +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> > +	cxld->interleave_ways = 2;
> > +	cxld->interleave_granularity = 4096;
> > +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> > +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> > +	cxled->state = CXL_DECODER_STATE_AUTO;
> > +	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
> > +	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
> > +	cxld->commit = mock_decoder_commit;
> > +	cxld->reset = mock_decoder_reset;
> > +}
> > +
> > +static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
> > +				      int level)
> > +{
> > +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> > +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> > +	cxld->interleave_ways = level == 0 ? 2 : 1;
> > +	cxld->interleave_granularity = 4096;
> > +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> > +	cxld->commit = mock_decoder_commit;
> > +	cxld->reset = mock_decoder_reset;
> >  }
> >  
> >  enum cxld_init_type {
> > @@ -1114,7 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
> >  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> >  	 */
> >  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> > -	    pdev->id > 4 || cxld->id > 0)
> > +	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
> >  		return MOCK_DECODER_INIT_DEFAULT;
> >  
> >  	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
> > @@ -1147,6 +1180,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
> >  	struct cxl_port *root_port;
> >  	struct device *dev;
> >  	u64 base;
> > +	int id = 0;
> >  
> >  	base = window->base_hpa;
> >  	cxld->hpa_range = (struct range) {
> > @@ -1172,7 +1206,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
> >  	 */
> >  	dport = port->parent_dport;
> >  	root_port = dport->port;
> > -	dev = device_find_child(&root_port->dev, NULL, first_decoder);
> > +	dev = device_find_child(&root_port->dev, &id, match_decoder_by_index);
> >  	/*
> >  	 * Ancestor ports are guaranteed to be enumerated before
> >  	 * @port, and all ports have at least one decoder.
> > @@ -1232,6 +1266,20 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
> >  	base = window->base_hpa;
> >  	if (extended_linear_cache)
> >  		base += mock_auto_region_size;
> > +
> > +	/*
> > +	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
> > +	 * endpoints mock committed, locked, empty decoders above the
> > +	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
> > +	 * points at a zero-size decoder, exercising the zero-size
> > +	 * reservation and poison-by-endpoint code paths.
> > +	 */
> > +	if (cxld->id == 1 || cxld->id == 2) {
> > +		size_zero_mock_decoder_ep(cxld, base);
> > +		port->commit_end = cxld->id;
> > +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> > +		return;
> > +	}
> >  	cxld->hpa_range = (struct range) {
> >  		.start = base,
> >  		.end = base + mock_auto_region_size - 1,
> > @@ -1255,9 +1303,11 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
> >  	 */
> >  	iter = port;
> >  	for (i = 0; i < 2; i++) {
> > +		int id = 0;
> > +
> >  		dport = iter->parent_dport;
> >  		iter = dport->port;
> > -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> > +		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
> >  		/*
> >  		 * Ancestor ports are guaranteed to be enumerated before
> >  		 * @port, and all ports have at least one decoder.
> > @@ -1307,6 +1357,26 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
> >  
> >  		cxld_registry_update(cxld);
> >  		put_device(dev);
> > +
> > +		if (!mock_zero_size_decoders)
> > +			continue;
> > +
> > +		/*
> > +		 * Mirror the endpoint: commit the next two switch decoders
> > +		 * as zero-size + locked so the empty-decoder layout extends
> > +		 * end-to-end through the switch and host bridge.
> > +		 */
> > +		for (id = 1; id <= 2; id++) {
> > +			dev = device_find_child(&iter->dev, &id,
> > +						match_decoder_by_index);
> > +			if (WARN_ON(!dev))
> > +				continue;
> > +			cxld = to_cxl_decoder(dev);
> > +			size_zero_mock_decoder_sw(cxld, base, i);
> > +			iter->commit_end = id;
> > +			cxld_registry_update(cxld);
> > +			put_device(dev);
> > +		}
> >  	}
> >  }
> >  
> > @@ -2085,6 +2155,12 @@ static bool __init have_multiple_modparms(void)
> >  		count++;
> >  	if (type2_test)
> >  		count++;
> > +	if (mock_zero_size_decoders)
> > +		count++;
> > +
> > +	/* Zero-size decoders require decoder[0] to preserve commit order. */
> > +	if (fail_autoassemble && mock_zero_size_decoders)
> > +		return true;
> >  
> >  	return count > 1;
> >  }
> > @@ -2493,6 +2569,9 @@ module_param(fail_autoassemble, bool, 0444);
> >  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> >  module_param(type2_test, bool, 0444);
> >  MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
> > +module_param(mock_zero_size_decoders, bool, 0444);
> > +MODULE_PARM_DESC(mock_zero_size_decoders,
> > +		 "Mock committed, locked, empty decoders under host-bridge0");
> >  module_init(cxl_test_init);
> >  module_exit(cxl_test_exit);
> >  MODULE_LICENSE("GPL v2");
> > -- 
> > 2.43.0
> > 
