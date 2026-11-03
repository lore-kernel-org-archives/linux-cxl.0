Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793690272;
	b=0nOBhWnNY3wVJG3IbdFNH3Hh9fLxR7jO9BVTjvoi9P/yA4FjrIgDAsf+MOXR1CQ7VwDl
	 zbhyhzFm9ZnxZhztwb6ft73CIX1VkGjde47IW4vuVRm9okxGhtg2+py5UEKs2HGzIodVq
	 c+bqvOEFQsMNGClntb9/azBHG3Uak5ZLcz2eejcOeidFhDGQ1B2ky5gRC/exWuAMSy0+z
	 6ficj+gydaL+tSgcLKHS+UF1e8cWAmCw/pK1WXT+ihQVasQnZ599SU/Q+sK/unoF/G06i
	 7CulFnJqrVhBK0zNtC2O6inseLT6my1nhZn3sYFdRoBdG/FaVnTe7nHV6qjz89D9xyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690272;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=26TT+xbY3I0nPow1sz/e6Ha8ZQNItNR2eeRxOhenSoQ=;
	b=sOmvhKS5XkPLj9BDy3dH3sKMXQd4R8K7JZ3tQCxqwckdCTKGg0noffHkoO4uTQx4q683
	 ylqr0YfAq6gmKH845w5NYsPdK+bkdadMvB3Jr1g1y2MDbe4FGaM7SDTgta1eKAPap+Xq6
	 ehNHY+ylFoK/0wXWWWusdINRocaoMWpiRs1ufKIf0xBREQeQ1xxxvEpq74mASV7HFk7c2
	 Ng/R7zbuinoNgiV9CFHAoeYk9tWybc+P/2hrIMU2I+P9uaJiFq0cWXMuYEi7ZN88z67VQ
	 GUKyzBwHCHPpisXDU5PAHOCTJ9A6KFeooMRXutNcaw7doqkbHFoYz9dqFFXbvBeuk2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l+ywl9qi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.57
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C6606A329;
	Tue,  3 Nov 2026 07:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001C6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l+ywl9qi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYjfkXmK5VoImmacku5breGy8wl7Z36xO6YWnc/iwRhlRbHn0xfAsZu4rZxYeH+Nbsovz8nYw62q24wJBEZP+JNspLl00cY5LjlqA5Y+XqN5my7/DCHvdu1ZGQ3xzE/Az/mdzPoOD/2PxcxqT0SKNpt+J//jc1qTogns2Lc2ncIElMnOcziKwjjv6ne6hMAaDR1XPQdC5sryhi8zhUYg4m/rpeCsJrmJIsgmmLhxLNHHfublUV+pO4/au3xwAtHZ92bMdL89z2fFWWfPM7wB3TlDBPXISUeK3KFvyFaz3DH8eeK+b99G5khGEB5dpSVRF9ESHahUqGfVkrQJN24z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26TT+xbY3I0nPow1sz/e6Ha8ZQNItNR2eeRxOhenSoQ=;
 b=lrZkWHeYgOomougLe7IjmElramEtPyt9GQvh4gYIBOd41qfbcYbtLlrYSkl+0uQRBI5SAjyymX6jLQrgdlc5ofsJOHl3teRmD9+8qpmiYhP9k4h4m7+Y6YduuoXP1lWDOg1jQb0w5wh1xMSD83LWwTRL6lE9Lcp7/K3Wsjoe4awaDSAFKZVgM65wCrcda5UNy+lXOMW3rKzKmcvDzGD9jDFqYxwKSPazHkY9oGkPi9kKEgjSchz49V12OPCodHTnD4KgqH2bImrEik7rrD3XuB5lGUtQSgtZqmDBD8UA5PoeJNOdzRRJ7bYkzqQjEOb2SA5gRg5HS+dU2Ec9dg1NwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26TT+xbY3I0nPow1sz/e6Ha8ZQNItNR2eeRxOhenSoQ=;
 b=l+ywl9qilnjGYm9+jPm259Tj800AGEQHfCsLI0TOeZsiKA7TqnB+G9UgUkohgDefvBXvA5JHYCEuR3t5OUjGfsT2oyIyKHlHlz3n+GSQQPJXOacfEO8rXVGIDMB9CSdfxklDf889d563my6W0PhCpVKKwDkxOgBgtfPUqA5v0lT0rYN6FKQM7EhLMQ3xRl3oGgWNT5r2P+GtXFg9SsRdZe3P8NM6DQfqDIcyU5QeFA6H0tKvTRj4+md3AKr8uYmOrhUYhJr/80C716eT7JAr6CXk7KRZqCsMoR2z2NF+WAnyVWJ04le7jcuLAb7HnEP7ARkDLzvGI8SPCBLCltz5/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:17:48 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 07:17:46 +0000
Date: Tue, 3 Nov 2026 15:17:41 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, kaihengf@nvidia.com, 
	kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com
Subject: Re: [PATCH] cxl/port: Unmask AER internal errors for VH endpoints
Message-ID: <aumKcxC28vRfs0rL@MWDK4CY14F>
References: <20261030095951.46080-1-icheng@nvidia.com>
 <e362b604-58da-43c8-bc3c-904becf92035@zohomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e362b604-58da-43c8-bc3c-904becf92035@zohomail.com>
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d105cf5-7d4b-427f-ae9d-08df397a8ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261022075727099003|261021123027099003|261102130727099003|261102123227099003|261021121427099003|261026121527099003|261009223027099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	DvkaO0Q0Rkv6YN8XjjfLL6fhxWACnZesLdcV1kJ/xWq5wdW8QjNw7XK2L4ugHcmOhcLuibtN5GJTjNNyxaUsx01PsINJ9RAylNCIjYsHBIrcCH8NILA5AnDThal7T83B9d8s8GIi9y8CXRZD2ieV7Q+zk4mlYQOsr9OPgfzJDoL0uMBYAZDQMPL+6RS8XKOAbXCXWNsB1dWXXHC7uLfwxmXWzSlNniFURkWOwn1LTqk71ndv4I5X9nYdKoruB/+m2KXFDMadSW8KmdutGeBQE+p80MP+wNlylLeJBaSI/YmQeE6ovdOJWybmbRyCwivAA9G1hTs2/KxtDYnb4opfOZ3sv7V74UAXQbjYFK2p3JTeq0pnJHF3LZqkJk/nCaO7ETdqX0ktYEOS0m2GN/LUtBUJbCe/b/8GQBj6I6f22KSgyUP/vgcjRdgvNsgUGk4OwellIgKmvuA1rFBzbCtDQT1A6+v2tz7MLnYlR4RXZ2Q5kICG6l8N7y/Z7iPXCidWeLVvHctnmV6Ks1nAn4AB6UIe6OsDfi1KRiPfRutpvsixX3TkFAEeIn3nkvPyKeapjAjUOySfwjx9N0NHNxiZW018P2PnxFMYduWeSgxw/FQV0yCnGm8uB9d2w87lJICc+4nbAjIHH+WeMAo2VcNkSlYBhwJ+y5y/MjzycsqZoKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261022075727099003)(261021123027099003)(261102130727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261009223027099003)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYJqRVRqWwSukd3cFQ2UPrrFv1IKO4MX1qZSvlWkc1fBKQabsR/C+9FlyVK4?=
 =?us-ascii?Q?WsDhRNuNjdFVXJibwPG9WKLY8ygMvQRuwG/YPCxf2somMEY7419sVQWnmI9F?=
 =?us-ascii?Q?b18l4pf1tVBK0zKJXfaBp4ZnfoA0+/vZN6NiFtEBywXAag/SerTLTuzmNf92?=
 =?us-ascii?Q?N8uKM+kD2OtKVHGLPgG6+lXJzpLNRVPaZ+rO89CdSd8/eysQf2Fndp3GY8JK?=
 =?us-ascii?Q?uMj02lS8q091jrUyyVbwd67YV/Wbc/APu7C8/b9ohItWynDC5wOovgqvmvLt?=
 =?us-ascii?Q?I7QkeghXs8lhuNfqAGgdKBmaGFsqenJx0aFeTM7kVDc9vZJfZ+ll0dm8FG1p?=
 =?us-ascii?Q?H655ksfq4zwSdXx23uIglrsTw9MeYu9YzvLAGKHkouh9b1MM+ag4rQ5g4DsK?=
 =?us-ascii?Q?UE5CzbfCn62S8RnpwmdCKUcqZPOMMdQXkITos0F2+N+k0TPMMnrWFk7xdJ5z?=
 =?us-ascii?Q?j+iUZG4Dfig7WiheEbotkVTi7zIuDJFFHDHij9RDPRoWe/NKkCJlpy0TKYuH?=
 =?us-ascii?Q?ASAzb/xundz4scSLTETn9CTYY9bFC5Z5hKZDyuDp8NHE8IAzEoA+T906lHs3?=
 =?us-ascii?Q?JC1CNyQBeeFJ3l2eMmH8iQshcP3W1EhQKUTFiYn9u6bIwjZ83dOgW40mpsMc?=
 =?us-ascii?Q?DGxezkrsYPTFf7ov99FAOn50GQuuXZgGoT4iXp1lbuEnsYRmrAhv+rwmI+rx?=
 =?us-ascii?Q?auq+8Hz2XNht9Hicyn/oTjjuFm73fTtR7MFCVIZwHeTGvlo6duSRa7x7/vgt?=
 =?us-ascii?Q?w9I9ke4HFdNx1AuFanlFS5TQwGIz30DQ3+mi9XAzwPE63WZkHAzwG6Hb/QXd?=
 =?us-ascii?Q?EL4nw4eXpBWfP7OY9ARsdLqL/4pPHDKBmDjJoYw8U/jrmE0MZrJ6fUtL0pqy?=
 =?us-ascii?Q?5OGLjpxApcsjuU1wL5llSqmPNhVboIYKaErDlyF0pEcZjWtZ4+UR18bNf6g5?=
 =?us-ascii?Q?fSLfuEJq972kUxnsXFwYyJxgnHl03+UX2Wz7xCHmYWoTXLqvd+iq3qZaZhzF?=
 =?us-ascii?Q?LdxefWYTAV7tpfIR6LiDLNdJAQ2ox0PWNTPv3TkLQywv7FsnhQuH42mPC4Ke?=
 =?us-ascii?Q?D1VY8iFKD7+fkhStcWBcMSzIAqMt7j75tYANl/x96NMdSTe2Ab0sQfD+v+JU?=
 =?us-ascii?Q?sdRHun6Bo29TdcDotWUr/Q/Hj34pjjpJ34k6S9QurTrOjN+/iOYnygsLTUPM?=
 =?us-ascii?Q?mSORkNryKyGr+fyT1nYn2YP1ZDnuQEhfHvIE2a1qBnOLEnbNLUv1XQXpI3Ja?=
 =?us-ascii?Q?SSPGHZPKqlykb9c6V27ZWdxcbx921s0vHxOWJJHY3clznfVOCQuXXtduOH3t?=
 =?us-ascii?Q?c9Nl2uOPMc4wtaB5YBUuuLeRRZVwSGXKAVnldRzqky2W/UYmEZEi5Pz1iByU?=
 =?us-ascii?Q?rCEQZhtqcABcSTkTWCY8sm23slBpLXbeRH8Pzji1BHGpdxbTjBGr2QXHkCRL?=
 =?us-ascii?Q?K8MyPSzJjjiR7Ch2cKr1V24Fgg+hM80CiNyWcF2d/pRkMsFtgT0j4w45KW21?=
 =?us-ascii?Q?yRaSjWZcFNouW9MnrGoRR4CvHzGHPhV77P1weghusMqrINDxSrhgcaAvXHNI?=
 =?us-ascii?Q?xc8cir6ROMuVI5KYV8ZrMgA9pUhXNdTBOTIllqReV8OV9G805RFc/xmQsx5d?=
 =?us-ascii?Q?+f1JwRUUJPFm5gDBTX7zYX1/6X2jefwMVTaAlU70rvA8IQKtpTSSF/Dvbm48?=
 =?us-ascii?Q?5M6jF7RFG5va9ihYlLCYY95nlE8In9vYtA57sAFJEZnXsEpy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d105cf5-7d4b-427f-ae9d-08df397a8ef5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:17:46.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBkkMWRHGJhkUsKkx+eFodm4Me07koaLrd+DvxXzPwDhnTjNASphwVskd6Fhgk227IBMfEjZ1RV7YlomahUJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

On Sat, Oct 31, 2026 at 03:11:29AM +0800, Li Ming wrote:
> On 10/30/2026 5:59 PM, Richard Cheng wrote:
> > CXL protocol errors are reported through PCIe AER internal errors.
> > Unmasking the endpoint's CXL RAS register alone leaves the AER internal
> > errors masked, thus the notification can't reach the Root Port.
> >
> > Unmask AER internal errors during native endpoint RAS setup for VH
> > devices. Allow cxl_port to use pci_aer_unmask_internal_errors() through
> > its module-restricted export.
> >
> > Verified with QEMU mem-data-ecc injection: the Root Port AER interrupt
> > fires, the CXL correctable-error trace is emitted, and the endpoint's
> > CorrIntErr counter increments.
> 
> I found the similiar implementation[1] in CXL RAS support for VH patchset[2], seems like it is under review.
>

Ohh ok, then I think we can drop this one.

Thanks.
 
> 
> [1]: https://lore.kernel.org/linux-cxl/20260902133933.2992457-9-terry.bowman@amd.com/
> 
> [2]: https://lore.kernel.org/linux-cxl/20260902133933.2992457-1-terry.bowman@amd.com/
> 
> 
> Ming
> 
> >
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/port.c     | 7 +++++++
> >  drivers/pci/pcie/aer.c | 3 ++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index c48216e5078f..c94a310061b0 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -121,6 +121,13 @@ static int cxl_ras_unmask(struct cxl_port *port)
> >  			orig_val, val);
> >  	}
> >  
> > +	/*
> > +	 * RCH errors are reported by the RCEC. VH endpoints report CXL
> > +	 * protocol errors as PCIe AER internal errors.
> > +	 */
> > +	if (!is_cxl_restricted(pdev))
> > +		pci_aer_unmask_internal_errors(pdev);
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index db4f607f889c..94eca22422b7 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1287,7 +1287,8 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >   * Internal errors are too device-specific to enable generally, however for CXL
> >   * their behavior is standardized for conveying CXL protocol errors.
> >   */
> > -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> > +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors,
> > +			  "cxl_core,cxl_port");
> >  
> >  #ifdef CONFIG_CXL_RAS
> >  bool is_aer_internal_error(struct aer_err_info *info)
> >
> > base-commit: f0c48323b0402349530abc60ea908b5f5f40c395
> 
> 
