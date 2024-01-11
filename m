Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5345786A
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jan 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="sBUxkdhd";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="AB1bOWd0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1705007102; x=1736543102;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=X4vGbiaqQJd/82GwKkzalsLN0YJR9dTvXxx0beBbHLQ=;
  b=sBUxkdhdnsHrl5XyEbFAgsEAhNYFEW2RtXBf+xt1++wMNO8CAeKadGZR
   ivuxdDLPFFDqDH7nIfVpEvAguuQLiaDlgulDlIoiZckrgWI3CKTLwP+3R
   UJRf/bU06nITlKOsXT64pp72Z8YjpRMGw+clUJ26tRwFhijQqX43OUfo0
   Y=;
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 13:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEszr91v7Uuh4Xb+jtmdCjnunWjnmFAzNOryTjGZ0wECSAaIOSU7p7AmJx5SMpHiU1mFb4wRLEi0pK0cNHihbwVeQW0iyWAm49ldr8xMIWfvgr73euOwnB5SI6rPCrfDU85hHZ6PiGviqa7V5UlwOmRK72bPabeTjd9QpMoPrR86y08GYmA6Yv4XfMS5H9qpAb/YdoSnoToLsO1NMKE4AMkx427GbPrGqaEkLkCUnKRHwDZofOJrmtPIxwVWaZrgLBVDcGSDh+1kOWh+E548HBUf3LJktX/jG0UOUZyfrfB8acnEcRifY0ABzrUVApRGH6Gt+YRJ29QzyOLQuP+rFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhENqYJdjVIupGcP/7plMhiXLkgpb3Ug/85Y3g1aP+A=;
 b=aMxjOgafaD1QhS++kTzK70l0GWIZKLw8YWaztv9/sU2K6Y5fzTjbLrmVdh2RboXwzQ7+5kjWYF/OmEF5/nv/TFRRfroMaNTGhfsdCcIb7uOiMlQfqChCaq+8N5zAJB9Ui6KuDnHjZ9oVQkl/UG1oTahWD/8SKjkmtvQizWWQwiTAOJKI37/RM7HiRic6XpjBkRW9O++61F6E7g4rCTMkwaUe+yezAO9L9BA9/DS4/X7oRVErGrLCb9OEb9aWWpDZtU1LxY2a6j40bMxErAWSdMxEWIwKsHhESmH2VjyuYk62gZHt7DX+z/YpDRhhuafCWi9YrnOxo7PgksYPXqdguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhENqYJdjVIupGcP/7plMhiXLkgpb3Ug/85Y3g1aP+A=;
 b=AB1bOWd0+u81AP+s+qwtLl5X3+xuKMOapq1CjXhR2X+ULLbmIiOJDXvBtPyP0edT+quKn7yDxs18NEKSU8Ssio4LT/lR+ju+oAgUI/lBuVfIzhF66ATxq86KmiZAjarJqfjWYmcV2FHfeR2+rpT6AyLGSShQ0FY7VQxjSb3Lx2E=
Received: from CH0PR20MB4250.namprd20.prod.outlook.com (2603:10b6:610:c4::15)
 by DS0PR20MB6534.namprd20.prod.outlook.com (2603:10b6:8:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 21:03:49 +0000
Received: from CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::8c89:934:cf4a:95b3]) by CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::8c89:934:cf4a:95b3%7]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 21:03:49 +0000
From: Hongjian Fan <hongjian.fan@seagate.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Question on deferring dax registration to cxl module for CXL_REGION
Thread-Topic: Question on deferring dax registration to cxl module for
 CXL_REGION
Thread-Index: AQHaRK3Mnl1f/YIUl0aRJ08pSclcxA==
Date: Thu, 11 Jan 2024 21:03:48 +0000
Message-ID:
 <CH0PR20MB4250F264AA40C6E9CF1F599C90682@CH0PR20MB4250.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2024-01-11T21:03:48.820Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB4250:EE_|DS0PR20MB6534:EE_
x-ms-office365-filtering-correlation-id: 6572165a-e1b8-44ba-7c40-08dc12e8cebb
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1zMuPwY5f4Z9hfPcFtg4/Q+xovk/CBlE9Zx9ZaJ61iq/C2VZD18UzhA1GLwuHrC5rG+rH2mQ2Ae02wh5wOkC6uzhh+6KukpJxArlkagmMfNjYO/CXMGdcJbDaUeVFZM5Y2pyCpd7gRkYf28wZjPf/1pvjjdfkYWDWMxpOeY7ZWpVXR0mVY3rLKxr3Il0k30OMhITDwdNNJegzK0yfHfF2BqvvT9cXG+G2lSKsntoMIJMI5K0otHUCc4gvLWE3q9x0TOgLXV2/DOnizCo0JP3/pDCLRHgHEyFWhIDHHB9gdusAZYsR10lUwLxpQmLsAgWJRocQAzrwpiiPFoOc1wreKx2R0D/461Qa0ec11UEPWdZ654YECbuBiSvpdfnQNYkmZ2UT4wkxhM6avIGUF1/XuEYFK3Xx29FSBQkAJVjFELJMjMeve7x+ZDe0N35x9xD1h794+NjVZApaNXyX+CBcAEUnxOhyhD3KFt9MdRGNQYACuMD36SraVAHt4D4S/ZyWPLPhst6zDs5iy+eYu0vEk2FI888CcDbP4EVsT48o98DXcgZOyh7rOlRE/64+QGWDRurZ2gk7trDhR3qSFom63f4aNcg7Goi6CHSme/zfuNu+abaGlIAkcSMzW8IZXpN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB4250.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(6506007)(478600001)(71200400001)(8676002)(7696005)(86362001)(26005)(66476007)(66556008)(122000001)(44832011)(76116006)(316002)(8936002)(64756008)(66946007)(66446008)(6916009)(52536014)(33656002)(83380400001)(38100700002)(9686003)(2906002)(41300700001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?V+UUxWmlc5qSWNtArbyecMGBXzMoNXiWGQYJqUfLhtOdgKqxxwap1qDz2H?=
 =?iso-8859-1?Q?uqeemQPzioLKpimsldDYmsLQ8kH52VRXbOFN0LjlcqtXJRSZUyXKIYfGVK?=
 =?iso-8859-1?Q?/aR1ohNxoCBkCACRPrbkkzyGfMM9oAf+CilNXPLqJHmwGPsV+JjDpT2JKX?=
 =?iso-8859-1?Q?poeN1ty8BvGd34ieCzqfZ5x5I09A8XjUmFe9A2B20dUWX3O6xdCdURpfWH?=
 =?iso-8859-1?Q?G8Is45gQVp4SGc2yZJd4SHrNaa/qLHdYhu5GeNdwc2/0/K3KGw1iVu1Ift?=
 =?iso-8859-1?Q?+B8xktGVdXK0J54cLgqiiqaj220sc+dE8WZY8xsYjmXOgVmLXymgNHt3eC?=
 =?iso-8859-1?Q?zKFyu+ZYBgcs8r7wpfo2c32/O4IixAwOYJ7QA9Y8GU720yFDrIwi2ugcsK?=
 =?iso-8859-1?Q?KqTjffjIagTVVxVEX6+ywCESeyLlB2bdcXaXsS/O5DD/K5kvCBt2EorAbV?=
 =?iso-8859-1?Q?AtEtQt75iQbcu3zO5DAr864s8ix40/NRDVAZ6ulVP7x8ahE0+4h1TPed+w?=
 =?iso-8859-1?Q?goW+nlRzgD59xToaQedmu8SLUroPUnJKZyVk/gq8Zhgy0VSDJ0FQnEs766?=
 =?iso-8859-1?Q?USKM2AxdHRoumlARYmjCAbcYZ1Nn3Cq7n6jXzKPcuyGIdspb/bmaOgLX9g?=
 =?iso-8859-1?Q?5HRF0IR+qs3fnm02YN7pV9VS6+PvuKc9oyrbPrA+ovo2FA/QVMvdW04BQY?=
 =?iso-8859-1?Q?BA/rjx7QXIACdvmgrLjv+YqoNQJgekcUHOELk3dux6EoEz6QF+Z2j650W8?=
 =?iso-8859-1?Q?F6quuIfeM3x7Fn2sZjtXpaaCOm986N0h6iex2UdeI/w38NjitXrTjjZT0+?=
 =?iso-8859-1?Q?0AKRYZjsrZvR/7jWjObwws0JUmQKclBfWgbG0nWPuTMCgG0eoj4LDGVsQo?=
 =?iso-8859-1?Q?H+Vb/jm/7VU4mY7xZo+VJd7uyVfAFHc3DmQls4RZbRZSGhMJ/0G5nDXdHi?=
 =?iso-8859-1?Q?l/XkWf3GNUuMiAYRVBEN5iSB0f2MJ3j85eoq9lDtSC3ODypG8cq22fZmwt?=
 =?iso-8859-1?Q?MxIh46zuUg/4tgWSMpDCUZL5HayuO1SHL9C53ujjkg3vx5H4OSFVbST2qQ?=
 =?iso-8859-1?Q?VYafMoKspohRPnkvuirw6eNikKihn7x8qdmmJP8ZiSinbYokrGd5orFPOC?=
 =?iso-8859-1?Q?14ZI/Pxoeq9QRVhlhuDDuePFnZ3Z/Gie2n9PIE26R0q03JX7/5qWhmdxXr?=
 =?iso-8859-1?Q?5ewy3oSUw3mrG9DOR70IX21vNYS7pwBDfCSopGYEO34wbkkGlSckXC5ZiM?=
 =?iso-8859-1?Q?YYeY5fUhaKwYq4LxqZn32GC2GcPIJbIwB63oXV3sDEnTKWzVF74LQuGIq7?=
 =?iso-8859-1?Q?Gi4JY3XgUrz3pwp75L1Y7zOEBj1qmzJLjF7+i/YWfNN0zlgLORhXHSpIXH?=
 =?iso-8859-1?Q?3p5AVgJBgGjQljPmAdBJMzUa3eoMS4Mykb0sq3+sIsm6Tpj9HIUCFEuDBy?=
 =?iso-8859-1?Q?FEcDM9LEq09l2i0d+eydvtj3U4DXU24t3Fp98g7FdwvkAXxCo1Q2kk9vCe?=
 =?iso-8859-1?Q?wACCPn+CwctsbSu+TudWFKGxciMqx8UItVUYs+FmgbgymsveuBWC0L0QL0?=
 =?iso-8859-1?Q?qI44Zkkja6a2Llg6w6LuKqgheAK6Aow64wYVD9e1PqUBak1xKeYffag8Kz?=
 =?iso-8859-1?Q?Z/FzN1pmsf1QCVH8mEtWMJdpO8rZoDfmZm?=
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
	VP3LgpH6zrNjRPR8pgAI0bUGVhrnupN330AsyG/MyUHiBX5kARIIApBLgr/k/01WIqyKkgaMGvRWkikab7q1rRJtUuHa63pwlqWmJ7Ekt+mPYl12cRc85mbeYG97R99ZmHBNY6bzDNafUcGh5YYiWTKx6zlgbPcjDQbWmEQpu2RF1x32TwIgVl5hrwL9KlfKEqwhZLd9QfeKVuX1jVbnKvGcCfhWzOw8jcSaqOdHsqXDabgX+761CNDz799LSiTdmkdaBqc/eN8SNCuK8hRQh3HjXjDlZvT01KO+YAPuqAD0GUeTrr/AxiR9Dg8cmqOBy4v8GrmcWtfFEs/e07XtmodHoCCEXGYrEjA5yAlUQUVIKtqoPCXmMy0uEw9R3fDwtmW6YgW11fiaNRA6z+PJYkiNSWcsuBzGpju6TvH0cyhKAhhodFMhIiMCX6qro7vdGyMyfMwE1NHPkCyNH/notrQkocaNu0QZrkzEKs1Xwb+A70a3JBE9FdKCYvC6vh6zrFs+h6ECRMQVYi3tZqI+gwpQKbt7+SoB2I1v6Vp2g9NKn8U+1tK6hWTdXOhgjko7L+1uUSyDTs9wIllFiC6AYMvdv3HZHsJNEWUMo84gkMbtK/PnflC+kjx1ZtPaml7z
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB4250.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6572165a-e1b8-44ba-7c40-08dc12e8cebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:03:48.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45d8Uc2YoFC8TKG1fYQh+6bPg6flZr5MnR8NItmNXSAAxxZyXwhRk1vn+LVdhLRrAPjay3DKHD+HgvE7biRQPDdi6eQ1diQ0xAQbrWZZDGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6534

Hi CXL experts,


I have observed the following behavior on iomem_resourece when CONFIG_CXL_R=
EGION is enabled in the kernel.

CXL windows are inserted into iomem_resourece based on CEDT CFMWS. If there=
 is only one CXL device attached to the host, the CXL window matches the so=
ft reserved memory range, and the CXL window is inserted as the child of th=
e PCI mem and the parent of the soft reserve. But if there are multiple CXL=
 windows, each of the CXL window is part of the soft reserved memory range,=
 the CXL window is inserted as the child of the soft reserved memory.

Function dax_hmem_platform_probe defers the dax region registration for the=
 CXL window to cxl module.
However, two issues seem to occur:
        1) If the CXL window is not the direct child of the iomem_resourece=
, dax_hmem_platform_probe will not be able to detect and defer it. This mea=
ns that if CFMWS contains multiple CXL windows, no deferral would happen.
        2) If a CXL1.1 device is behind the CXL window, and the dax region =
registration is deferred. The dax region will not be created because CXL1.1=
 device doesn't have the HDM decoder and other features needed by the CXL m=
odule to create the dax region.

DAX ( and hmem ) module is not visible to the CXL device's features behind =
a CXL window, so it is impossible to defer only the CXL window for CXL2.0 d=
evices.

If I want to make dax region show up when a single CXL1.1 device is attache=
d, I can see two potential approaches:
        1) Do not defer the CXL window in dax_hmem_platform_probe.
                Can we simply not defer? Current code will not defer if mul=
tiple CXL windows presents. Is any issue observed when multiple CXL devices=
 are attached?
        2) Defer all CXL windows, and let cxl module create the dax region =
for CXL1.1 device.
                But where should this creation be? It would be a long path =
to handle all the unvailable features from function cxl_pci_probe to reach =
function devm_cxl_add_dax_region.

Please provide your comments.



Below is the /proc/iomem output from my hardware:

1) When there is a single CXL2.0 device on the host, the CXL window is inse=
rted in PCI mem and the soft reserved region is a child of the CXL window:

        6080000000-707fffffff : CXL Window 0
          6080000000-707fffffff : region0
                6080000000-707fffffff : Soft Reserved
                  6080000000-707fffffff : dax0.0
                        6080000000-707fffffff : System RAM (kmem)

        A cxl region is inserted under the CXL window by function discover_=
region and the dax region is registered by cxl_dax_region_probe

2) When there is a single CXL1.1 device on the host, it is similar but neit=
her cxl region nor dax is created:

        6080000000-707fffffff : CXL Window 0
          6080000000-707fffffff : Soft Reserved

        HDM decoder and other CXL2.0 features are missing from the CXL1.1 d=
evice so the CXL driver will not create related CXL structures. Because of =
the absence of the dax region, there is no numa node created for the cxl me=
mory and the cxl memory is not usable in user space.

3) When there are multiple CXL devices, regardless CXL1.1 or 2.0, the CXL w=
indow is created under the soft reserved region:

        6080000000-807fffffff : Soft Reserved
          6080000000-707fffffff : CXL Window 0
                6080000000-707fffffff : region0
                  6080000000-707fffffff : dax2.0
                        6080000000-707fffffff : System RAM (kmem)
          7080000000-807fffffff : CXL Window 1
                7080000000-807fffffff : dax3.0
                  7080000000-807fffffff : System RAM (kmem)

        Both dax regions are registered by dax_hmem_platform_probe. The cxl=
 region is created under CXL Window for the CXL2.0 devices.



Thanks,
Hongjian Fan

Seagate Internal
