Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79F482ED
	for <linux-cxl@vger.kernel.org>; Mon, 23 Dec 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734997789; cv=fail; b=fpLmsQuoVwmX2EPPfpDtW/AZzQtqMSo56h+CXdcb7ggwVPAr06qwOpLXWJndc3WlxK3W3h6IofdBupwWeTr6SupcE0IWznXfRCB9+m8sBnuB2JvGr2vKAzg/4D1vHEjwlohpF+dbVKbZFhaCuaCuyGEH7eivFobpRapvwJ2E/dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734997789; c=relaxed/simple;
	bh=72vydGCI/yOlJk3qDR4CXd23e4ZYBK9xqBZFN0ehlOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H8sHdhKODrOg5uWIpXRan3zxFvAPKcPi/c4YB682Pu8/MT1u8Hun0rDsfwXkT/tg8yBvC3yDVRe8h+TOXN2CmWwH1zpPsqqlgb7Qt1/aY245RPZgphZmL2VjKc0SHYkQXCCq9xfePs42b2xMuzyDmuUwNK79/nvlZ2i+HkFuU5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I0a1rNp9; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0a1rNp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsb6+UI3lr6TnoBp2MH9Fz4OTPnb+TtADWXSZAElmFJKCwekRi2trcPf2PcQ8GXLeZriZPu4gfocNRD9TWGgdwRXT1pLvk/1308Hk2b/5mFYXzDeE/mHMCLOvJHaYaejJ73QgP13rKJ++VOPtJXL8dE2N1ZDcqDK7AxbJvOGFZLb320WCvx4nYUbZy30WR0LEwU2tTeBPGViZRShNFZy+uTY/kBePR9UMaior3G9vdhZCvWNYaJoljhLHTPgy3CL4prODiKjvn+kZ1ugenqndNYv7589g/F2FCRjIcl6Qz1rKXHsPNrF6zmyLcpca4yMfEits1Hdy+nkfr/PfWOhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RD9ySESUEwevyWVHTNcrvmdMGGATWAq5QP26l+94lM=;
 b=NoBkH8XN3KJTJDCi8YBqFcnn5Orje/5JmDqmaIjMPjkGDIXpYiPBr3mtAqDA5oJ9DDqTwl4P5I+NJrcg2FQ2NLP0em7ujtM/TGcE8F3lNeMLFKYIl6eom3cMyWVSB+OjMJIpRjXYVxw/PNa4lwm4SCJAMKppF9GB1R3eUd4KYNv9TgxYXWxkILrEcZ1+Wuh1GSnvvI0nQpsXScf7D9qx4OaiAkkmgDyM5YlKmrBQtV1ra9uBXeg4ERMeqvC8vZ5DUgzhaB+vanxpS9ESIGSmz8aW1rBvYT5LKcreyREc+RlDeoXYPkg/cyqwzd1ZUBAn7K7AYUIdUIJ0UIKVZPqYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RD9ySESUEwevyWVHTNcrvmdMGGATWAq5QP26l+94lM=;
 b=I0a1rNp9bPLeI182Bf//ixAZffwCSKBMyGxruDWoqYyXbQGYZRHE8oIcK0jyB5T49MF0qTN4RdzfEgz/nBohaBsjRGco1bPaMcGxcaE+UqaCo7+x7VnrLY07aPki+sVRFUwCRC0gFv251cBrj9c9FS8po/+e6wQOKBDByUy+F8VnGW/aKGiNhlC50XeRntDn7xOQ5jVopZTAsnhf4kzX+0ioWgs0wfHlR4QXijbt8KlJ0RRbWBfu6D1tP6k4qhYzAHs4wX6U4C+bMoboaev5F24c60x7y8rzvDoaKwVLSZivx5pC8Qc30Kc3nAwFz3F+lrz35NoxsBdimhWoZR36jQ==
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Mon, 23 Dec
 2024 23:49:44 +0000
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85]) by SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 23:49:44 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Ira Weiny <ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Vishal Aslot <vaslot@nvidia.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC PATCH v1] cxl: add support for cxl reset
Thread-Topic: [RFC PATCH v1] cxl: add support for cxl reset
Thread-Index: AQHbTTJ+/rGT4upjzU6dhrL8dd5SYrLqsG0AgAT5FvCAADE5AIAEs0hc
Date: Mon, 23 Dec 2024 23:49:44 +0000
Message-ID:
 <SJ2PR12MB7963AC888E432469404E4FC8C3022@SJ2PR12MB7963.namprd12.prod.outlook.com>
References: <20241213074143.374-1-smadhavan@nvidia.com>
 <6761ae926757a_2a169f2940@iweiny-mobl.notmuch>
 <PH7PR12MB796800828DEC6E60D7C7C0F1C3072@PH7PR12MB7968.namprd12.prod.outlook.com>
 <676603cdee673_2ec99229411@iweiny-mobl.notmuch>
In-Reply-To: <676603cdee673_2ec99229411@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7963:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: 3e8328f2-9695-4f5c-6774-08dd23ac7a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?X3N7Qg8VGe5Jg3ZsY/OaFjstKbTBGLFFoXWVX1pktFPKmink5fdlcrfRRB?=
 =?iso-8859-1?Q?CQAloU2yNKW7N8//1aj0Gcjb2fMhlNPgPp1hRVUkvXug6vFJT+wIxgwu8N?=
 =?iso-8859-1?Q?WOojga+/vZ6j8USW0mTnh2dxPK/u//5r9RD8KlnGhtZo5icLWIT4hJcwGY?=
 =?iso-8859-1?Q?4zlHavbpWTqFyG5AMPXhWFJ+ZHK6Nv9ud6Yhh1ZGyCtne3ZHVZSvT3WDo5?=
 =?iso-8859-1?Q?Dg9cG4E+TK5QY9D54+ZofPudVO66MIUVNDncuk8V1kNVEeK/jLq8vMpIxL?=
 =?iso-8859-1?Q?+pYRl5a58vxvPGOvPlHS+JVS7B8abV2w//omKMPiNxMq2z2cIF9GyGqflM?=
 =?iso-8859-1?Q?M+VlsdZG82h2v2G1UPrmr8OEWoiVBLF7/6xuID++q5uRnekO7yC+7b7BfT?=
 =?iso-8859-1?Q?C8Ec78sXTTtqejkvG7xEeYlRXrgYu6WIyu0zfjzNIH6rnfDhaqYTQoPmFe?=
 =?iso-8859-1?Q?ORMUmfY4Ttrc9hFX2ecdKzovhhVIwDJFPwNS4jZXAId/3CuGsfisBP1Chb?=
 =?iso-8859-1?Q?WStILK2lGb5LMz0cNFoRuBD74MBiHwHIkijBpGlV2Da1b6U2GW8v9tKjyc?=
 =?iso-8859-1?Q?If47NRou0gHBZvtQUbyj+ZX8n84GfimeXHThuw91OtzaQWLX6+IWNgST1R?=
 =?iso-8859-1?Q?8fpmPQoISINzRtisoutOXkSDD2QwquNZTevrlNb/bUO2S7zLE59JIrcn6L?=
 =?iso-8859-1?Q?B8ItMbwqUT9n51nQjVZRHPo4p/AKfFTZ5NyKGjRB6uA4PdWZ7Cxw8rwBlg?=
 =?iso-8859-1?Q?pEpl3GK7Vipl70CaLg19zVFBzvEDYHFVcOKYGka77KCcGpOnNUNzUYXUEY?=
 =?iso-8859-1?Q?63IRWc4VUwvBwXRMjBhMXuVJ7nefwJDagUKv3ygsGHF7cmnUFPki7T937n?=
 =?iso-8859-1?Q?QCtvn+tk1UacTYTRhBHubH+qR4LM2OQT8LCl1pT4MXj7nDTMDFpaKkA2AB?=
 =?iso-8859-1?Q?AFhFOwQ6bJewvGPMTjLOxKJYE+JEvBu6XnWdhBiR4HzySggFB/so9SQ9UF?=
 =?iso-8859-1?Q?Mx0MKrvQC+adDxn1gc5sAGSpl2jgjeewVY8OGJRC1TriYiP2oqUeFhHQ7M?=
 =?iso-8859-1?Q?xDQSk79TUyHyCMgRZzZx2gTUcfrj6XaD7KP00dTap2AGQBvGRKPrdnzBOm?=
 =?iso-8859-1?Q?rYd9XmC+RabPk29iLAaL8sxxxpCcGk0OXdifeABZPP3zgHKn+ot5dtUp0r?=
 =?iso-8859-1?Q?+AsM1P2xdPMKd23TdaqB9mUf6cn6C6jwEMll6ZJ67CEbtqv+5FU/nynHMw?=
 =?iso-8859-1?Q?Yj2Gm2XdYZTV+tMh+82IhznmfwKOv47GeXoDfNpn1pJIgNNvjjXRQyurgQ?=
 =?iso-8859-1?Q?7zDoYaYaqaSGhHdnp1aMOfdGYudHDj8G1MGsgrb4FwPi3xMDJcGKbs3w0W?=
 =?iso-8859-1?Q?8TQ0MsijYCLOcPJ4Vhd+LeBXCuI58yyWDueqo+l4TUJ45C+EviPGj0QA6z?=
 =?iso-8859-1?Q?31OCflzcAQ5SeYNv/cAhwnMXMqitEpOztKKAEHb0l1m67BxjHGM86BHvBZ?=
 =?iso-8859-1?Q?7/wpIocHCdAZfJg60EGTun?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7963.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oyiv0/+XLYmcnxh5jRMeX+VPe0ynbFmrGl5Ak6m0rm4E46Q/Lj7leE6I2W?=
 =?iso-8859-1?Q?cQxrOql3DOACttozrrdJ0ZBmPHx+LTQYMqxqbFSgBRwmYNnijLi+/Tf0bH?=
 =?iso-8859-1?Q?l98cpn891hJhWrGGo0mNN8OG7Qvw64aWZwnZYCzYxHtaWY83Oq7/quMr8T?=
 =?iso-8859-1?Q?PydNGHkHcQAClsfWEb01co7HZuORC3D/vcxFtaNnOYU6gyvyodEG1zxE8e?=
 =?iso-8859-1?Q?VhCF3hEi5E/uM7KPfqAvfgcuzankFrzSvD2+HwEebedqZTJoKG23/t23gg?=
 =?iso-8859-1?Q?4lSViIbVAPmluO/HzTe4Z2Dgv/DBZx92qfXiYZna5qDpWh9x+WFeCRW61r?=
 =?iso-8859-1?Q?2B6R4zv9X9x2BM+T7epaMhwkJ46KS+YWfTdZ7of3AaBOUBCBEdXRLHs3Ni?=
 =?iso-8859-1?Q?6Qfiu5xdpcysN7Nf36O+7dxeUFLZIHp7UF5l+NTgZ3M6pC4R43ZZSZ4YXu?=
 =?iso-8859-1?Q?Orzv7oimRdr92SAZR20H7qYtZ3xkhxVFge1lFmU6mcWWWMRGP8uoZSi7Pv?=
 =?iso-8859-1?Q?x3OqXoBa/GLoP/TMMguyHBfHgjSUUuvKjWD4aYdI6EYEnrAnl96qneqgmO?=
 =?iso-8859-1?Q?4/1BgJAEWcV5NQPiK4eFe0ma/KcLVcxIktoa/i8zKPdeIgnLm5y+YqucCw?=
 =?iso-8859-1?Q?sJRpBgvh9o3ARfeVXu+vvGt9XbhI+6BfQgU2pQSqTCXX/6ZK1hoPO841HT?=
 =?iso-8859-1?Q?z0k12eZScHQwvZQo8OGW63rVZeU3LtM8gunmhfyqag/7v8jWfhRAzXsgZa?=
 =?iso-8859-1?Q?nJ54Nx5vkDWv+krhIFFn6g4z/KS7YOEpd8RPJLyeOs12BIxMQYbuhoHjFU?=
 =?iso-8859-1?Q?toBFWhW2J2qgHeahlLniUMXd8halK0UNjeVfxFJ7OX+/pcx+e5+j/pIsff?=
 =?iso-8859-1?Q?e9UZU+1JlBMOcVqmhBmmogT3aqtvviswftN9LnifCoTjDXMAE8ExwBgUih?=
 =?iso-8859-1?Q?HC/3HdxX01lVdB90sD50G+zeLJi258Ci9/S/1cNb73ceM2XXijcDkoEyJ7?=
 =?iso-8859-1?Q?NcKaHhA8fqjYZkOTgtP8aO/hv0lcP1tPlHhZ5v+S3McODoOCJgAvCA56QK?=
 =?iso-8859-1?Q?hhvgc91Owca3PKzFbc+eviWjbXngrbxYu97LwGpoQuI+zkO8mHlFYh+kO7?=
 =?iso-8859-1?Q?FGCC63jQ1zR95llfItb2UHiS37wZ5Tw59CkodLQq+CQDR+Y8K4qmXkfl44?=
 =?iso-8859-1?Q?mRafqGptspveKKEpbahHbPS60L/pK/x5xYm6z34hRlnzDRW1+rVQyvzudQ?=
 =?iso-8859-1?Q?Z0FK7Gb4xqJepgAKaJEfHAZbhheT8K4Li3svqo4XkL4tY2wo1yONk18xT/?=
 =?iso-8859-1?Q?Po5DM7UmXVQrd/Ujyjr8aPO2yN5q5zicMjZQgZ2INDpdTbh088rI99aDWy?=
 =?iso-8859-1?Q?iR4P0VuBVV6+fL8iM9JcjOOavVcAJkckYVML7ZwnZRA5tVs+mOzEzkl1Wb?=
 =?iso-8859-1?Q?ZIg/iLYHNXbwr14sNubL05j96ADSzpkLKVrasAdbi/uRj/4zF6EcOP/dih?=
 =?iso-8859-1?Q?uv5/a5uCxc6u8iMPj7Ww2SHszpVlO+ucikpustmJTp+pmGqN4BEETD0hEy?=
 =?iso-8859-1?Q?BATDm2j8wj1JYKeABm+StD2buLbnIElZ5X41PdV4v39bl0MG4+kiSQ0s/x?=
 =?iso-8859-1?Q?7p0qJ+D69Gsmq5cIvyrVn1bdOqWbRlbMPG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8328f2-9695-4f5c-6774-08dd23ac7a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 23:49:44.7259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8b+/rzAqfQIJTjf6jJ8UwpqFhT6KgTZnd01rLLzae1cHIptH96G3othGo1Vp8tFYsau7FSXWqtnP+CThP74VBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004

> > > What happens if there are current cxl regions mapped to the device be=
ing=0A=
> > > reset?  I don't think it is enough to flush the caches.  Section 9.7=
=0A=
> > > talks about system software requirements for the HDMs.  How are those=
=0A=
> > > requirements met with this patch?=0A=
> >=0A=
> > Considering different platforms might have specific operations to=0A=
> > effectively clear the regions, some type of optional helper routines in=
 the=0A=
> > CXL core would be appropriate.  This way if required, a Type 2 device d=
river=0A=
> > for example can choose to use it if required.=0A=
>=0A=
> There are a couple of ways to go here.  For memory devices I think this i=
s=0A=
> on the user.  But I don't think that is a primary use case as I'm still=
=0A=
> unclear of why a user would need to do any reset of the memory device.=0A=
> =0A=
> For type 2 devices I think the use case will be device dependant.  The=0A=
> specific driver in that case will need to tear down their regions (with o=
r=0A=
> without user space coordination) and then issue the reset.=0A=
=0A=
That makes sense. So in either case, based on this logic, I am assuming=0A=
it is out of scope for this patch to remove the the memory regions.=0A=
=0A=
> All that said I think this patch belongs with a series which implements=
=0A=
> some device support.  Or is more general for type 2.  Which is what=0A=
> Alejandro (cc'ed) is working on.=0A=
=0A=
Thanks for the feedback.=0A=
@Alejandro, if you have any thoughts on this, kindly let me know.=0A=
I can proceed based on that.=0A=
=0A=
Regards,=0A=
Srirangan.=0A=
=0A=
=0A=
