Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8881642D
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="bL0EPSOu";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="de4cA558"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1705099167; x=1736635167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Aeiy+B/QoCnqiBoFYwzaG+gNTlwYjh4f3nGPdnTWb8s=;
  b=bL0EPSOu/d1Ct2A915P7Lso3LXisaOmMayJ1rS7S7/DyUoD1JjKdf6o2
   ijQIjB/B7C+T+UB6bGvNghi8+SxmwkAO3WivhyZp4+M/hdFrlfVtNEUmu
   iJaErEdGQB5BmJtVU4J5XGDUQUIkzVJAATYrNdFjXXyVpOlPxtnUHh1o1
   I=;
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 14:39:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGWH7oZajADX8ZITIgf8lV+8BI+tqbdjlPhgQStrRoH/7ZUYMG4VTTGFNVF2zN8lmQI9tzJQqXg+ssmjvF6L5vDPX1od/5IiY3W2mLeJBw1WQeyRDGQu+i5pJDPOgdGjFE9HH/M4fnFKigwtvC/NvaeIEV1RiffIgdNgCiFLTTJlQqqdZCoVz5sXUITAtMvpUZnM343lyaErWjRL5kDKJwJPa96ZcOVtXb644NefKwpKljnndoIzH0lHfyIC7sQMTZI6sXdK4Xhubg5q7gwvqBHSBnJkSeyYLiWdAWx4acyeFcJQnauOzr8rJEt+G4fluPcaSoLEG+flK9KDH5nkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE4FILlCb5K9C4r3JvMlJVdap+Ybpf4yBx9ezKrZf9s=;
 b=TOY5rKBhysaGKg1IhGrnHOwJ82Dv4PGQJ1M8z2JQlKUOvTieC22pgoGQcbbWGc/t3AS3EzH2GWFGZIJJe1BTcpsZx2MT4O4yOvyWF5efRuysl+kKixNXLMvFhiXJeJ+GA0u8e8nX3mqY/KhN/Z7TYrs4/dl1hWf5rOP00Hwsd/HKr+GL+ZRGklpZpNCc6VQdRDQnD6AL2gXDlcIoNtHPi0CtP/zrH+/ZNf7ND8QK+/u5ytU+Lexjpqua6Bt53dLQxVQV0kjUeqmine0RoM/78SlfEHcO05OWSv1POMHqUDS3JA5yfT4LBXJk21bQPLWi2Z1kG/dJ6rKnPFkOlY35vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE4FILlCb5K9C4r3JvMlJVdap+Ybpf4yBx9ezKrZf9s=;
 b=de4cA558G7qkaJ4e81mk3RYzPMgLm783X79yIeZn077eJ+Wf2Jjy7wqIisaXofm6vE1yVrMatE2j1Ir+C9WHSsMAdjQkKpblO5xgwrjmA/F7iZ2ufw6zFs7XtuMQPfu+a/Te6o2XBuEDn6oNeHAxbTOb14Y/o1tqxO1+UWf6zYA=
Received: from CH0PR20MB4250.namprd20.prod.outlook.com (2603:10b6:610:c4::15)
 by PH7PR20MB6069.namprd20.prod.outlook.com (2603:10b6:510:2a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.20; Fri, 12 Jan
 2024 22:38:56 +0000
Received: from CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::8c89:934:cf4a:95b3]) by CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::8c89:934:cf4a:95b3%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 22:38:56 +0000
From: Hongjian Fan <hongjian.fan@seagate.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Question on deferring dax registration to cxl module for
 CXL_REGION
Thread-Topic: Question on deferring dax registration to cxl module for
 CXL_REGION
Thread-Index: AQHaRK3Mnl1f/YIUl0aRJ08pSclcxLDVUrMAgAFwZ+c=
Date: Fri, 12 Jan 2024 22:38:56 +0000
Message-ID:
 <CH0PR20MB425003081E303307CF57ADB1906F2@CH0PR20MB4250.namprd20.prod.outlook.com>
References:
 <CH0PR20MB4250F264AA40C6E9CF1F599C90682@CH0PR20MB4250.namprd20.prod.outlook.com>
 <ZaCHSE13Q/KJAZQU@aschofie-mobl2>
In-Reply-To: <ZaCHSE13Q/KJAZQU@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=True;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2024-01-12T22:38:55.860Z;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB4250:EE_|PH7PR20MB6069:EE_
x-ms-office365-filtering-correlation-id: 9c4bb5df-7c85-40cf-15ee-08dc13bf42f0
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hf/8X0M1gXuwR3Kwug6y9g62tD2bwEb5JbhEUwviqjrwW8t0fqkoEk+AfV6bS0H0+t5rJ+Zz3z7BvoACWaQlaIqn5fCY6zYbnP9e6j8ovE/b5T5wTeRu9T0KhcB7vquvRxvyA3GeqUDZ17fLGOFGe6dv4+MmyjH6el/HoBmRdmJJLPc55E8Szkoh5OJsZx3d9mcjEncOuUK+Bs0F4p+z5Oa0zmvrFX44hTq9tBb1flkkY1afNfz7gjsXCh6F5w6G+I6IzTuAn3yDscbp4MMUI0/zbf+oxCBUNDB0sYORMy8MBwbju6AEAhLPhM/kQgba0d5e4i7Hon889xlAjGG3xYknXuz9GFNvBEqw+o3m+uD/nHologw89EYGmy0pFCG0IZLmfyUR6B8yK7dfSB7GzgxQSNCCOcuuko0GMVqAPbLEZeuPsxViiLnS4GIzhkEJkdpkudSCa5IN3zLdeNb3dsGffpTvQ97PT/YdASNIXpkAyBAEVF2OxSImqr4Btuk+X2MIz46lMlK2mCxq0AoDwoLEcr9yVzPpAPIspBm+Fd2if84gkJ9+JuMN7sMY5aVPcByuwe5Lmt1zqLZ8EmIyKYZXzx3w/bokaanGgqL1gio=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB4250.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(71200400001)(7696005)(26005)(966005)(478600001)(6506007)(9686003)(83380400001)(4326008)(41300700001)(44832011)(76116006)(66556008)(66946007)(52536014)(66476007)(64756008)(316002)(66446008)(122000001)(6916009)(2906002)(8936002)(8676002)(5660300002)(86362001)(38100700002)(38070700009)(33656002)(66899024)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EqeM8dihxbi2BatpzSKs/0GJhkvc8wT2NfGTDxJPMYXuVnPmVUOjxryRRR?=
 =?iso-8859-1?Q?CQp8iuGXhU9eGG1oGq4LRl9T5vBQj29hbIT5o0TTnmT3piQ8AGg/Ahe50W?=
 =?iso-8859-1?Q?l/eLNLFT3p9vqhTg7t1p8FTNwUcJre5n78nkPaHWfurW6ChG08Er3fRGP8?=
 =?iso-8859-1?Q?qpAWL///Z8tMPOHaavGkHWMvsf+Ai36nxfHs6NWA160ZZcmJ23QHPK4xRB?=
 =?iso-8859-1?Q?JPXg8uLlIS1Jkmbl97ufQ3BXzVNobbfkeY+rfMDS26SHD3jbGrEuQgRY4z?=
 =?iso-8859-1?Q?dbhk36NHZU6LQLZ4ZDVW7eTeB7RalhLFiPc6Jo8gudEbafdvqtXzeK0ge5?=
 =?iso-8859-1?Q?8RuDvqkFBGnw2dqfiyznTs/ipXJhTgZqcyUjhl9ma3kSLgXaK/piMZ+hzJ?=
 =?iso-8859-1?Q?zEo4K9nmanoUR3tOS0GtgqFAeQsXjg+tlPUyk8NMWcaHSV1C+aSJ0Thfc/?=
 =?iso-8859-1?Q?S/+YECwhqkGc6jpObJZyAERH/zMfjvm+ChBw5lwFwuyL73ZSODO1cX+ev1?=
 =?iso-8859-1?Q?68/dN77NzOG/MzU6k3dFFu3rRUo8R0kB8WkYH3NvIlCimF/lRuv7zxPge5?=
 =?iso-8859-1?Q?XaZJ1PySH4hOXSL2Mc5cMZmV7WUUvk3ZE4o+F5Ly60zOmTvMJtoSv5R9ul?=
 =?iso-8859-1?Q?kFka17tBPnsY79sFGmtOtn7YmRWf4V2hSfqrDPFk8PKWRLPQUESFUBu+1w?=
 =?iso-8859-1?Q?gRiiabX6XbJg2s/AilhL8y76/iCAaXjngtI79nlgYwddFievqsrecDqUW+?=
 =?iso-8859-1?Q?muxmNHVddJbg+GGsMcTPnFE1WGl64rjpb2/kG55IsyUQrBY7hzSboBGQcm?=
 =?iso-8859-1?Q?a6qiFXMsDZI4e4GmMtpfzIlfE2J7KB2fD0/pD+5jiJcIfHNbdMruLJj5b3?=
 =?iso-8859-1?Q?CmAtR5fokmBswa6YhmWtxFPjAiIK6x804XaXPsDUNOkZUZnKUqZ+f/3EzI?=
 =?iso-8859-1?Q?rNNxCEVpQYymlgz+KDXbO3iWqVzyFDoYskPz2neDiC87sFnACe8wT8v9L3?=
 =?iso-8859-1?Q?CeBsVisINWleCXcGbyYylhku4PxO4ijIaljOivXqIbJKBIaOs6UVxgBuUr?=
 =?iso-8859-1?Q?a5gtnT7TTm0wOM8gPQLTe5yGa1C2Fr54UiWoKEPc0qxMhrJ1lsY73DzJb/?=
 =?iso-8859-1?Q?1lJF7JelFH2Edi0rNrVCFDPIzuFfg1L8DPUGI2Tk4Mf7ilJ7JYveJKAQSk?=
 =?iso-8859-1?Q?mh27evCs2+uEjcWRwDn4oONm6Eo017rpQDgghfHnL7O6LX2eEU7d9+n9l3?=
 =?iso-8859-1?Q?tkFZaug/qmFq2IQGrA4YUs3g2SjLMCJV+PdkZJevAi/LoENW7a2u0Wdy1R?=
 =?iso-8859-1?Q?B7xbnr8QlpcV36pkedN4DiPGp0rAAg0cTMl8lAFuZzk5ThmvNUH1EcZBaV?=
 =?iso-8859-1?Q?7nWtOZtP+sIkrkPRZBj8kHNGUS8/Zs6oi3OH4fKO8PRztkiovOhIflw4Qs?=
 =?iso-8859-1?Q?Nfsn7X+ubowJFB6MvAhKJewj37NvjeH5K5Je39kYY3zuDOnOluV+lQa8dH?=
 =?iso-8859-1?Q?SKnxcs8m+7X/SR3iRso14Ep+xwK+PxqPkqt1CLfWoqgDepPFl8wdxT1/+E?=
 =?iso-8859-1?Q?mNTCd5/DVNMZgw4OyCOanV6OF/2MlH1C9/QmsA8WjKOTmX6OiWWg27/hJg?=
 =?iso-8859-1?Q?XsHBQZVLDRtAOV1Ehjl8vV4synb++HuR51?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bKOOW3Ahp2bJA0ccGBxKcA6GBA/+6njME2PeRKC/4ZM5CufEI2wouejO6zzq4iCVW4h9kLqxenv5Y4vMmD6KAzNOmB1l0BjbaO9e97gmoQ2RgAm1v5faGSyRxzh8v6a9S5hLDLI058TOrRgdVlFN2RiJOQYuZewV5f6nMMmuK+JU4otXM7msoBJknNyc7lRvAB4HDttx5uQjezBi4xIIAcLJ2KIDlO/RBLsj6aMFXknzLJSLrs+UXQjmaDqXpV1Wl5s7RhNoyMYprMVkmNSWpd84mNIxYvTi5v7MecOdf8gUoTb4OIpSHUn10yA4ygg3qXYQg4WeEeoq8jFeyraux8CNdr0/kC+9xt1MtjKSBHsGv4tDVZhCTd1U30rUXV9Zqbr8OmoOG6xal5kl9Zs14H75Lm2KThXwmKjKC618xf4huhiVAH+c47T/L2ltlj/jsQaWY9K50x8IJcCAb/Gj/obCy4Fo4A7qPomMf3nppF64n8SqAaaRkHU2OFqOtTp0M1DrG2UxkzrvYA93w92S8xmEDVpPlG5sKtvST2Sq3Bk4woSYqKS5JriC3Pmh5um1zfnMvcwB6HzITh4q/qDd0cLCHj7ibXq3tcl8k4yM5vWXViR46GMLRSltP4+OZQq+
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB4250.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4bb5df-7c85-40cf-15ee-08dc13bf42f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 22:38:56.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDKOYU7iRdAwgRsb+WZc5ekeyGQCOH1yKe1Pd1ndjYzl2ikK7EKi8JY/qBtBRh9JHRkUZwjfUttadv0nw91ML6Ihzg8gPGou4Z0+WHnCKXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6069

Hi Alison,=0A=
=0A=
Thanks for providing the information and different approaches!=0A=
=0A=
> =0A=
> On Thu, Jan 11, 2024 at 09:03:48PM +0000, Hongjian Fan wrote:=0A=
> > Hi CXL experts,=0A=
> >=0A=
> >=0A=
> > I have observed the following behavior on iomem_resourece when CONFIG_C=
XL_REGION is enabled in the kernel.=0A=
> >=0A=
> > CXL windows are inserted into iomem_resourece based on CEDT CFMWS. If t=
here is only one CXL device attached to the host, the CXL window matches th=
e soft reserved memory range, and the CXL window is inserted as the child o=
f the PCI mem and the parent of the soft reserve. But if there are multiple=
 CXL windows, each of the CXL window is part of the soft reserved memory ra=
nge, the CXL window is inserted as the child of the soft reserved memory.=
=0A=
> >=0A=
> > Function dax_hmem_platform_probe defers the dax region registration for=
 the CXL window to cxl module.=0A=
> > However, two issues seem to occur:=0A=
> >         1) If the CXL window is not the direct child of the iomem_resou=
rece, dax_hmem_platform_probe will not be able to detect and defer it. This=
 means that if CFMWS contains multiple CXL windows, no deferral would happe=
n.=0A=
> >         2) If a CXL1.1 device is behind the CXL window, and the dax reg=
ion registration is deferred. The dax region will not be created because CX=
L1.1 device doesn't have the HDM decoder and other features needed by the C=
XL module to create the dax region.=0A=
> >=0A=
> > DAX ( and hmem ) module is not visible to the CXL device's features beh=
ind a CXL window, so it is impossible to defer only the CXL window for CXL2=
.0 devices.=0A=
> >=0A=
> > If I want to make dax region show up when a single CXL1.1 device is att=
ached, I can see two potential approaches:=0A=
> >         1) Do not defer the CXL window in dax_hmem_platform_probe.=0A=
> >                 Can we simply not defer? Current code will not defer if=
 multiple CXL windows presents. Is any issue observed when multiple CXL dev=
ices are attached?=0A=
> >         2) Defer all CXL windows, and let cxl module create the dax reg=
ion for CXL1.1 device.=0A=
> >                 But where should this creation be? It would be a long p=
ath to handle all the unvailable features from function cxl_pci_probe to re=
ach function devm_cxl_add_dax_region.=0A=
> >=0A=
> > Please provide your comments.=0A=
> >=0A=
> >=0A=
> =0A=
> Hi Hondjian Fan,=0A=
> =0A=
> This is familiar. In Aug '23 I stopped work on a patchset [1] aimed at=0A=
> improving the soft reserved resource handling. From that cover letter:=0A=
> =0A=
> 1) Soft reserved resources were observed as sometimes being the parent=0A=
> and sometimes being the child of a region resource. Patch 1 clears up=0A=
> that inconsistency.=0A=
> =0A=
> 2) Soft reserved resources were also observed as stranded after region=0A=
> teardown, making the address space the region released unavailable for=0A=
> reallocation. Patch 2 implements soft reserved resource removal.=0A=
> =0A=
> By v3 of the set, we were rethinking the approach as Patch 2's juggling=
=0A=
> of soft reserved spaces seemed silly and error prone. Also, the folks who=
=0A=
> were hitting the soft reserved issue during hotplug were able to use CFMW=
S=0A=
> address space not in the Soft Reserved range as a work-around.=0A=
> =0A=
> Dan offered a couple of new approaches since then:=0A=
> (I hope I'm not misquoting)=0A=
> =0A=
> 1) Insert cxl intersecting soft reserved resources into a separate=0A=
> (non iomem_resource) resource tree, when / if any CXL region assembly=0A=
> fails walk that side tree and move them all over to iomem_resource.=0A=
> =0A=
> 2) Given that it is already the case that the device-dax core waits for=
=0A=
> cxl_acpi to mark ranges as IORES_DESC_CXL, and that we do not expect that=
=0A=
> to fail. It means that cxl_acpi can then turn around and ask the device-d=
ax=0A=
> core to cache and delete the soft reserve address ranges. Then if CXL not=
ices=0A=
> a region assembly failure it can signal device-dax to release that cached=
=0A=
> range as a new CXL disconnected DAX region.=0A=
> =0A=
> 3) CXL acpi walks the resource range knowing that at the beginning of tim=
e=0A=
> Soft Reserved ranges are unparented making them easier to delete and=0A=
> register them as "just in case" recovery ranges to device-dax.=0A=
> =0A=
> Can you comment on whether any/all of these suggestions seems to address=
=0A=
> what you are seeing?=0A=
=0A=
So the goal is to have the flow of  ( defer -> create region -> recovery ).=
 Let cxl module to signal the recover might be tricky because there are so =
many places the module could exit before having the chance to create a regi=
on. How about combing approach 1 and 3? Creating a separate resource tree f=
or cxl intersecting soft reserved resources and use it for recovery. =0A=
=0A=
> =0A=
> Others thoughts on the approach this might take next.=0A=
> =0A=
> Thanks,=0A=
> Alison=0A=
> =0A=
> =0A=
> [1]  https://secure-web.cisco.com/1_-vlaqCzY403VxKY3uh275hNxVtkmKw-ivst_y=
1c2018jAb-ohPZQ9l9BjAdn2Gja8wR012IpQsvtfpqB5pBZf3Ni4Bq5QKvZ9eRhq3selFEDjOZL=
CLZ4KoX1AvPkGx6JKWiXd05MYRRrlE4INdiE4Ynwa-wrk7DgZCJFtfP2Q1GYlib57E_26VnA-Bc=
_wUtb7YHaz9tVexsNatKD-Hm5DofMPUO0K8aPf_1VkWIOO5DSBrDMoO2EyZVa-P35U1h_3Dqxwn=
yHtnrJbU2jsexgvPbax750fTP1cifhb1-WfKvtjabUpo6tk659S0PeihX7_ikum30-TaJscvo9y=
ZpJTr8-xAVNRG1hhfhJRRGG8b5LjCm4KCkwiO5kw6wNXrkqmTnskhGd5k9MD95D-3Z7jGBJ1NjJ=
RQz1OVdLXWUgZU/https%3A%2F%2Flore.kernel.org%2Flinux-cxl%2Fcover.1692638817=
.git.alison.schofield%40intel.com%2F=0A=
=0A=
=0A=
Thanks,=0A=
Hongjian Fan=0A=
