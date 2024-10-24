Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7F1714B8;
	Thu, 24 Oct 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751425; cv=fail; b=XEnO6/O7Qq3M9TeEjBJ0h3aXyLCUjRNSFad7//9vKYRFoR/+6aDZxInyXFJlTR+2dI2xPD6jtWdLaDGXlw78EFV8YRmXIZI6ChxaufqOceyaGQiA7ciHK64aNN3OIfJ+S1dU3iZdTyIeVBeBxqTK6vcYH/1i6BW1GsAX4TIOmcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751425; c=relaxed/simple;
	bh=Ffb0EiMNLu1AthPBDKm5doR9Bet5IztXw57nXCvdf2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PFobZszFt9a30YbvS8Q4u9IbF/K7GPPehGEXsPTCNrl6DBaLQXJ7KGMi7LRRiN5fO5p6TX0BjaBvkjwmqbvoqjVj/gxG8bNJFBDwQqeP5/1wR/Fg7DWOdhZB3p+M/K1BZjsLkiLtI3/4zWofDWVikU2KBvuiYtyVrp3feBoiN8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=oq0AldDq; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="oq0AldDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWBxKDUWSf+DvpLjh87Sdhq4IDXAHL7Atki4wWZX5egUruUBWbb+sueJZhKRIMZpJmi3oVXiX7AhJYnVyNd2kw5qqk18ocnmA7azX3NEgZJp08fzjUrrAzPqlk+8cnCm4oyrsPlmylGESzzWaKL6AAUrn3vv+Cjdlk81DDPTyiTHFOcWCiv+SKfrZCQGZ08SmO83ZmmQ6bkhZMqLLOK1mDd1yv3kJMU2EkcabGeO4Y118u0jpikuLT6EQmMRgEi9S99PmoJbwO5o82BJriB0FT8VEcRFRs8Jh4ms8s4qICEXSVnd4XIY2h84l7169osAqP94hG04h1sywDm7zaZmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxQugPLF+d6YWefxebQl2fDDcaY1K8RjN6VwfWZ8Vtw=;
 b=goWajPFS2saJufB+kliXRm2SN6M+VAGyQ41edI8YQJb3GGAndlur6OFs27gmjGzq8hGfLXVwXRePqceuEWcRCe3kUD9ZThdnH+gFv5hV+879T+0wpxjUB2MjAZfgD5PljWEVwB7ZZ9/A1b2N11msSR+ozJV4/eI4+YRhd9aiSPytqxcuh16ez1Ci6xovk1cqYsIEZ7rU8AM20CgyvNmcHEfyY9qbsA557bVm8mn0eCz8QR5AWXzdOtCe9bP0c5IbJK0AV/kD9mfVyCAVFMNIl/C4zUh3G6jW5aZAxVZBpAdsl8v80qfvXeVsWUmFKLNDE77qeLI6Hlz86xu6zM7r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxQugPLF+d6YWefxebQl2fDDcaY1K8RjN6VwfWZ8Vtw=;
 b=oq0AldDqassXljM5dzT6xQD6RH4AnF5ZQYrI4FKmk0XuCxQJWbr6wH467AA5nESBTcSZp44JW43Pnw819SNJpf/7EAwQsoo7HkQxfROnZUGJVZFbf86WHKlKX0DfaNP1DWSTVmBp9kdisHCemjUexls8cWw1nNDBt/LdS9vrxdyaLIOoQKN/oUWMjkqh9zzRmFlplFX6kK66n6t4aGjflUOCPa9gvShLwvJg8hXzZEOu1+fTCr6cMu1datsgGlei3AAfY/g3cbL+CkTri8AbSE+RLddENT9i3o54BnS3QghtfYUQhCWlnVY7/1Eic2Etc9fM/9xgwAx1AdDrpnCyjw==
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by LV3PR08MB9026.namprd08.prod.outlook.com (2603:10b6:408:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 06:30:15 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::1d) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Thu, 24 Oct 2024 06:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Thu, 24 Oct 2024 06:30:15 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 00:30:12 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Thu, 24 Oct 2024 00:30:12 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>, Eishan Mirakhur <emirakhur@micron.com>,
	"Ajay Joshi" <ajayjoshi@micron.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl/mbox: support background operation abort requests
Thread-Topic: [PATCH 0/3] cxl/mbox: support background operation abort
 requests
Thread-Index: AQHbJd4tFyIRWc+oYUqCZjxvTarO8g==
Date: Thu, 24 Oct 2024 06:30:12 +0000
Message-ID: <750047084f2e456bb639fabfa7189b20@micron.com>
References: <20241022031809.242591-1-dave@stgolabs.net>
 <feef15c9fcfd462e9b3cf614a1b4621c@micron.com>
 <zrmn3j2wzzlnzzwunk64xfy4jussoiek5ro73qs3yrjqflemtz@zbn53a27tt6y>
 <d4fb5d07a2994f6b9b36b1ee4c7e6563@micron.com>,<vtj5cp6brmyvqut6xaxo3vfgnidvzwxr4kv6ofuiimcga5dyke@ts32khqtmexa>
In-Reply-To: <vtj5cp6brmyvqut6xaxo3vfgnidvzwxr4kv6ofuiimcga5dyke@ts32khqtmexa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|LV3PR08MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 859a7b02-aadf-4bb3-1d67-08dcf3f5527a
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?OiUcx0pHbs/7NGF2NMrjWgvY+IarSo0aWUOrgmTq0SubI28wocGy6GbZ9c?=
 =?iso-8859-1?Q?yOC/Yn1KO2H+5BMlarA5W3fxewaLrGfvap1rwStuW89nxKrU/PSpkEcjuh?=
 =?iso-8859-1?Q?MBAWGssjtVdbF+8aBgDTvmu0qIVbwrylhOcC5P+R1EKPqV1S5mUqpo7Nu3?=
 =?iso-8859-1?Q?unDyRths23RYPoGyRTLxSq5ObQE2bNcpSYPfVxgRoBJJ9WG0Ork+LfArGy?=
 =?iso-8859-1?Q?1OOjVA4uBuYGf10SYWl5zhBvBZKNf/7WidOFYiQvd30VUarBJ2pujgImuz?=
 =?iso-8859-1?Q?Ha1aahjSGuM7g+bqZtnJU2hJug87YG8haInlrv4lHzKFjS9g4CrRWHkl0K?=
 =?iso-8859-1?Q?No+0loOiq79akB0FuE2jRYlKQn8lloR2y4bNZSW6JbSLZNrYW0oEGI0FQJ?=
 =?iso-8859-1?Q?T7vVh7cshXjbd8u51jQh6n2gqXUTYEOV1tSD3oHGCQUh32aJhs6SPE6BJD?=
 =?iso-8859-1?Q?pvt/RT4lCoXuMUzGO24ed1HDHoL8PNvb4jg7L/DlJ/iJ3fU0WR85KWj+gN?=
 =?iso-8859-1?Q?D3D6Vd5NzlbFGb6mSZqIK5NrkFvv6XTYzdAKoyxyTdgpa6sXBglG4wEgbG?=
 =?iso-8859-1?Q?AE3T73ESCq2tEyqy01keizr/4OtAUTDcjNh13NdlC30Ks15u3xIO6d4I5s?=
 =?iso-8859-1?Q?JjXKNsjyTxU39Lt1HWJUYYFKsYBhtWNL2r8L1/hFXbw1B/2ISJMYc/a9Jy?=
 =?iso-8859-1?Q?phQuUkFi918BI0s8IcFnOocngo/bTZVJgSy9kN9c+Ksz/wjwe4jmlIWklk?=
 =?iso-8859-1?Q?G/ycVKlDdVPTUi/QfXa2Lf+xYBb9rhSCroNYHDkqTkeEaP6VWLAxDRiITi?=
 =?iso-8859-1?Q?hmynjx8pciNriLQTNEZVHC3LPeHRhcEkKbCPckJ5G2PMoIa1KbiM70KSeU?=
 =?iso-8859-1?Q?Ip0VfJgPsGM+gJcXdbk47dgOEFMyBXLjsuCTpRjKJ39JtXgnEbff1T5YTN?=
 =?iso-8859-1?Q?wvKmsaqnrCLKur682V5Latio8jsI7f9xkaTCoIB+0PMr1vJFWYZbyEgVrB?=
 =?iso-8859-1?Q?0t2iClcCVGE+fFemXB9fEe0YmWhXnWziOLbAFrZ4cz/oOekNxpkH2IoMOR?=
 =?iso-8859-1?Q?ROvVFKv9PG0xq9S2BBqFS+eZLgNj3BwS8Jrna49aNsSTfgJ4lhayAZ0Tj4?=
 =?iso-8859-1?Q?naQf12gnqNN9oGW/yy15HRTxb4URZTXlAgvr+XJRMHjcB+j0kiIGZxllza?=
 =?iso-8859-1?Q?qAzz50p1muLPlTWscyxobwLj6fm29sONyCOjs2yyPlLrgPhjcP0/HpzY4N?=
 =?iso-8859-1?Q?3/HPoISbVMx0bFBB7lhyIO8iOqUQXVDedemBvv8/eYa3DN6GfTnrvYVsg8?=
 =?iso-8859-1?Q?vzj/Di1l0JFaxi31kZGWsYPQA7sD9lUAuz/wpNT6nVomCGGuuQcfvLyWcN?=
 =?iso-8859-1?Q?xkOjQWsZvLUzf4qlrKGs9IDb8ldrGof0eJlXFuA9wQ5sr53xjc6KTqbQur?=
 =?iso-8859-1?Q?wmCIYZRGyEZe1fLW2aQ3RHkAy9iXPo2xnPMLrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 06:30:15.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a7b02-aadf-4bb3-1d67-08dcf3f5527a
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9026

>On Wed, 23 Oct 2024, Davidlohr Bueso wrote:
>>The one major functionality in our original proposal apart from implement=
ing abort is
>>
>>Allowing background commands to be invoked from user space through the pr=
imary mailbox
>>by ensuring only those background commands are enabled which also support=
 request abort operation
>>by checking their individual CEL details.
>
>Is vendor-specific logs not something that can be done OoB?
>
>If we are strictly talking about CEL details, yes this series could use th=
at, and was
>planning on adding it for an eventual v2 -- ie: why send the abort cmd at =
all if we
>know the current one doesn't support it. But that is minutiae, for kernel =
bg commands.
>
>But yeah, for your needs, the enabled cmds would need that filter.

Ok. we can merge changes related to CEL checking and filtering of enabled c=
ommands.

>
>Then with that, would adding something like the below address your needs a=
nd below
>questions? Basically, if userspace is running a command, then the kernel c=
omes in
>and wants to run its own bg command, it will simply abort *anything* ongoi=
ng as a
>last resort. And since we have no kernel-context about whatever is running=
 at that
>point, is *think* it is safe to assume it was user-initiated.

Yes, this seems a reasonable assumption.

Currently user space doesn't have a way to initiate background commands
through primary mailbox as there is no provision to provide timeout value.

By filtering out user-initiated background commands which do not support ab=
ort,
we can potentially have a default timeout or allow user space to provide a =
custom timeout value.=20
=20
Overall, the approach to cancel current background operation when new bg op=
eration
is initiated seems elegant.=20
>
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index 7b0fad7f6c4d..bf0742546ea8 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -374,7 +374,7 @@ static bool cxl_try_to_cancel_background(struct cxl_ma=
ilbox *cxl_mbox)
>		mds->security.sanitize_active =3D false;
>
>		dev_dbg(cxlds->dev, "Sanitization operation aborted\n");
>-	} else {
>+	} else if (atomic_read_acquire(&cxl_mbox->poll_bgop)){
>		/*
>		 * Kick the poller and wait for it to be done - no one else
>		 * can touch mbox regs. rcuwait_wake_up() provides full
>@@ -403,7 +403,9 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_m=
box,
>	 */
>	if (cxl_is_background_cmd(cmd->opcode)) {
>		if (mds->security.sanitize_active ||
>-		    atomic_read_acquire(&cxl_mbox->poll_bgop)) {
>+		    atomic_read_acquire(&cxl_mbox->poll_bgop) ||
>+		    /* userspace-initiated ? */
>+		    !cxl_mbox_background_done(cxlds)) {
>			if (!cxl_try_to_cancel_background(cxl_mbox)) {
>				mutex_unlock(&cxl_mbox->mbox_mutex);
>
--Ravi.=
