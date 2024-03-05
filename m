Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30B5DF05
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633768; cv=fail; b=uuDr3tEQEZFgmyQaDOUnXmqkzHYFOn0DCQQQH0wVHEtIZ6/8A/ythUBJEUYr1i73oSr3Q5pl8i/15e1bmRxhsWUD6dQQXomlYeekqoMQij5WLcMFrDaBdAnBFNTK0U0fsge3+USBCAoym5IcVKsQ8oT9e8K1+5ARgg7PmFLmFIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633768; c=relaxed/simple;
	bh=WZ9K8TCxneeJIpQYF5oV+smZ39lJOKVZ5XW+kJ0ahX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMRAaVbZa7tW0wbDym4n/Th8zq1jWSP8/5oeYIvqQPGCSfOLp3aAhR68o+w6/ekuDig4jPt0lbYaafRjzGGYQaMoLHkzbW64ruAwX5VjJY972Uk6iiKBp1+JEdxeVGfj/bzKgl/7cxqtuxV/+ogji0xU/ByqQuo0w5TVdpvfUU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=UoSbi53Q; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="UoSbi53Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYBDXPFjnQ7iRliCuLSIjZzw4fGdFm+UucNzZnKLvxefwH3wqc75H/YWtXoAfG0hatQV1MbopKEK46fjQTZWA5lsYtj3QjhRyhcFs6PJ+h+wZUSLhKjlqhsce6HEeYVWHgK0rbMcQSDWUDfZNJoQ7m8w05GnfWu0N55C2ns2a2EcE0MHM0+/HdnIJ2Vavt9Zjq4shX8XgXPWpknlJxwXMprdgcLpCuUP1eVUWyKMpRqc58pk4gd+48JJRSZKGTaDs6Cc1/ryokwKtCT03g2ZJGaM0l4QjGLnUmh06q0aYre5f72dpqvOoCFFoFXSa5/IrSeGpsTLfFTk23b1Ob/Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb+rXWSU0yUufy17C5czBTA+FZPKiaI8VPFt4mjhO1U=;
 b=Uz8ANgdJRC2vvlWe9XhON/jG4q1HIFaTfdmCMJjpSkUpEr0tWX/0V3L4V/ewIb9CqcYGu98hgwEJDddSJvd4u/raFLS8BIyJgBdT9u+wUXWPIPWfn5iXcvF9OWxejg+Z3Iuo/JpWo3X8eGWCnWVIT7ckfyA+gIp1+rRXoQjjMKB5u01cjIBAnnO7+6BoBSFQlidK6YYwEL8A4jgDHjkEgp4QSAa+5FfI9nTERrgOlQYUwgWNPTiEhO7V1Larenui5iMkXCov1sdSWLT9ZF5l4HqpeByldP9glsX0tmN8FIeeWe4IYF0gIHUnFiFyMas3nlTqxkPeInBYWbCIrESPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb+rXWSU0yUufy17C5czBTA+FZPKiaI8VPFt4mjhO1U=;
 b=UoSbi53QfEbO6r+b7L6EZdMMgetz4f2+IMKHsM7cC+4Bx2fSitEwUSCnyOPfrIgJ26YqiHW8KWNkf10PgjXTr+CAe2k7XncfySaaxl6M7IQIgiKzsxNQ5JYz6xluCsCXc0P9TAHN8GdJ++UdKQgfiWIGSzL+gl3bNzpc8JahBSor8oidMvzPVUDXaBAOKXpN6warIdhpKs/bvMs8ZtwnR4uW6Ahy/N0GfrU79iCJKJ0WgLHN4pHU3nvOd0piHh+iZ7vPSzMB5TlcXqtTg9+3FYNmMXWOV2B15WngdLInSPiTGkAfzA4RPtE2A2VsZj9GgDGrzXGiMIB60Dgh0xaUDw==
Received: from CYZPR11CA0004.namprd11.prod.outlook.com (2603:10b6:930:8d::15)
 by CO1PR08MB6596.namprd08.prod.outlook.com (2603:10b6:303:98::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:16:01 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::9f) by CYZPR11CA0004.outlook.office365.com
 (2603:10b6:930:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 10:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:16:01 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 5 Mar
 2024 03:16:00 -0700
Received: from BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f]) by
 BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f%8]) with mapi id
 15.02.1258.028; Tue, 5 Mar 2024 03:16:00 -0700
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>
Subject: Re: [PATCH v2 0/2] Add log related mailbox commands
Thread-Topic: [PATCH v2 0/2] Add log related mailbox commands
Thread-Index: AQHabuYetwOARg/uKUeac5mGYlviyQ==
Date: Tue, 5 Mar 2024 10:16:00 +0000
Message-ID: <a5e634b79b284f55802c73a188540ca9@micron.com>
References: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
 <65e631951ff61_b62b294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <65e631951ff61_b62b294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CO1PR08MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 639fb919-40a3-442e-52a0-08dc3cfd4250
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OywWRE3vW8DG/2EGotUTIkwnEf9TUPsM114TJnEWXABrwPeP5DUt9V8sJ7gNKt5RUfdJ3d8R859XHlPxuOlFPRa895BBia4bBw6/BiF1hnuxgBWWAmIJkopI60PJm9PtUJFQLADiapxjBTp+jSw5gVx9nF+0uygpAydNfJeVDO/eG478h6x4VjBxxCe2jEqf7fib4kkfXC5uA6bz9Tf6IeDp03fXh9POHhZPJpFpLg+nofZg6sBhe5Ytw8TihB3xoNRV3y2v14Q68+mlv6pKU/SX8Kh/UoqXe/iZaCgNJme32FdYYVh78EAcNk9VeB4lhjktta4i2nJDeMewFEePaEiz901+Axhju62ngJim2Vm7GRZC7/hG6d4AlJmO49fJCVjdNKoxQu9hKZgi2kaawKl3bOMcZcRk1iwF1TZo9+VI2mCBx/qmEGeC+tYO4++Mx78UXbMLzbTjo9IFtlgi/NYbuAHFA198vjAXZ2aRyJ+019935a7mlLjT8IEVfwKwtYFl/blxUt4nsNltJeIRaLh3ywSqxshomGBfl16ONV3Td4sRmUPGFh6yO/fBjArTm1F26KqcZJ1eSU/rrmbyD33VZzBety/IOIdukj+25ug4yhKhRdkxCEWZcsvYDO9u5CQWL8xhpW+i/R/n9542dK/qd24AaDF6T2OfFaljzx5rYMF/qy/SOeIV32Ey8SoM50IlXqSrjEZXYV5YHrtOCTZYm+erIpI5kfq4uyp+0/bxyB0w7miEqVchznf6lOzn
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:16:01.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639fb919-40a3-442e-52a0-08dc3cfd4250
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6596


> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, March 5, 2024 2:10 AM
> To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
> cxl@vger.kernel.org; linux-mm@kvack.org
> Cc: Jonathan.Cameron@huawei.com; dan.j.williams@intel.com;
> john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Ajay Joshi
> <ajayjoshi@micron.com>; Ravis OpenSrc <Ravis.OpenSrc@micron.com>;
> Srinivasulu Thanneeru <sthanneeru@micron.com>
> Subject: [EXT] Re: [PATCH v2 0/2] Add log related mailbox commands
>=20
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> you recognize the sender and were expecting this message.
>=20
>=20
> Any specific reason to include linux-mm on this enabling? I suspect this
> topic is only of interest to linux-cxl. Lets drop linux-mm from a v3
> posting.

Sorry, it's a copy paste mistake.
Agreed, will drop linux-mm from V3.=20
>=20
> sthanneeru.opensrc@ wrote:
> > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> >
> > Add support to expose following mailbox commands to userspace
> > for clearing and populating the Vendor debug log and
> > Component State dump log in certain scenarios,
> > allowing for the aggregation of results over time.
>=20
> What is missing for me here is why the ioctl() ABI is suitable for both
> of these. The Vendor Debug Log seems straightforward to enable via
> ioctl() since there is no background operation entanglement, no
> population complexity, and no reference to other payloads.
>=20
> The Component State Dump has several caveats in my mind for ioctl() not
> being a suitable ABI:
>=20
> 1/ Populate Log has an unreasonable expectation that the submitter can
> monopolize the mailbox indefinitely. At least that can be solved by
> Linux only supporting automatically populated Component State Dump logs.
>=20
> 2/ Automatic log population requires the caller to handle races with
> auto-population. The kernel need not export that complexity to
> userspace. This is not fatal to the proposal, but it has interactions
> with caveat 3.
>=20
> 3/ The Component State Dump format wants to reference events in the
> Event Log, if the Event Log has been cleared then, per the spec, the
> Component State Dump must not reference the Event Handle. To me that
> implies that the code that clears event records must be careful to not
> destroy linkage to component state information. That suggests that the
> proper place to dump the component state log is an addendum to the
> current trace events, before that code clears the event record.
>=20
> Something roughly like this:

Thank you for suggesting this approach.
Next version V3, will add "clear log" for Component State Dump separately,
as suggested bellow. Probably as a separate patch.

>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..498b2a0b3e76 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -941,7 +941,8 @@ static int cxl_clear_event_record(struct
> cxl_memdev_state *mds,
>  }
>=20
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> -                                   enum cxl_event_log_type type)
> +                                   enum cxl_event_log_type type,
> +                                   struct cxl_component_state_dump *csd)
>  {
>         struct cxl_memdev *cxlmd =3D mds->cxlds.cxlmd;
>         struct device *dev =3D mds->cxlds.dev;
> @@ -977,9 +978,12 @@ static void cxl_mem_get_records_log(struct
> cxl_memdev_state *mds,
>                 if (!nr_rec)
>                         break;
>=20
> -               for (i =3D 0; i < nr_rec; i++)
> +               for (i =3D 0; i < nr_rec; i++) {
>                         __cxl_event_trace_record(cxlmd, type,
>                                                  &payload->records[i]);
> +                       if (is_event_referenced(csd, type, &payload->reco=
rds[i]))
> +                               trace_csd(csd, ...);
> +               }
>=20
>                 if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>                         trace_cxl_overflow(cxlmd, type, payload);
>=20
> ...but in general this cover letter needs to comment on the long term
> suitability of the ABI.
Will add more details to cover letter in V3.
