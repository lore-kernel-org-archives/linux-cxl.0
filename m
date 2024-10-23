Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E813BC11;
	Wed, 23 Oct 2024 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661575; cv=fail; b=NUU2w+uT16HmFiWTzbg1XZs5HPyh378krUQRixniATNXfdy5mxcoR0eVyL0kwbTP0ogW1nnMNwKZ1fePn8iZPduboRqy98JG64ObWFZITrRnAA0nq1a3hXQLifmWHIrQM+8xPmF+DvfhrHGmuNwxTr9bMSFoOhzNFhnX7ni4idE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661575; c=relaxed/simple;
	bh=c2R1crE5R57T7GERSxfg/fHz4lXMxm3AfdphDmnNpz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNW/ofdINlIjr5pK7GprqV55Ryq8T/JYqC74hpvnsb9eoPxQ7A2mpo0QA5J0yzkdhJgAT1Q0446Jgk0ovE7LqAjRBCupFVCo3Xnrl6gpmQDiFKv2OhES/jXGtl9g8uuMZZBkxl33g3+2ILr9qi2Oeb0HZAe/gHjrjOAsPFu1OTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=oRK4b7cd; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="oRK4b7cd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpPJah8Q+8Vrw3g8yOBK2ziq5oRo5igQdRsxASZ7l9xHE6jimr6VEGDR1mIGDX9aD98V2e0sUkM0pOoOrvL3PcMp/t5+GXiXEGNw5o2ZtkJS/Hv49LIvQmN/3jgiSxBnL1hl0IVtHUcpy3AOc6O4nc3hZ2DZ9IagPCnY8uRMIsnBcSaukuyhLYVZMhyWi2oORB5vmEQeAjR0snASovlVKTyDPxu/GLhKbO3UqJXn68yi520TCxFVrxIR8uAVHocO2msNv43Bj0J43bqOoDqPQDaLk1NEECK+d64SuEx2UHY5LhFkK1L3xC6b4ukj1nNXAHSyPk8g7Q1CCNOJLmPybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grDOyt8EjVlWoKUGRr2+zv9Ss+SXxSEiwJ2LGzLiWWE=;
 b=gNhxIf0SChBjtCmnrqaZnpfwwXv3zypqtbj+myRF2uPTeb0DzzFE/8JldqrrBjr+rPvtFE/IL/Su9BLNO40SaqHneUgYYLjoUx2Sgx8DZCt8WNAcml4L6d14P2xPHtJpp/7Heem0K6iPLQdHauYoq5ttwTlpou+TBwCQdeKNWXkLjUnTfMI39RZen+BX7Gg1E7RfH3QWinEME6LcvLLP77WdRr7MHTKXRmLNipV5ksm0dk/63L7Kx/vbx7yLPlVkfW0HvJuwii6HbA7DBFDXWjaRKZLJ7FnC59Vv0CfXVC3L9QmAtqpedZHV0wzqi/bJneCbmEbAijJKTSx3e1Vs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grDOyt8EjVlWoKUGRr2+zv9Ss+SXxSEiwJ2LGzLiWWE=;
 b=oRK4b7cdOoCMirv09maUQmpfNmzfyNWAcXzq6EKHHYzFKLu9GPco4ZJa+9xT7tw14bRHWxbfHtp80iCce8DWcfTk7u5S5xXbZEZL3oqBKsXx3bxii/KFHpoh/+73JjtPxn1bRiaS2t6S2TsRikqFrGsNA/5e0NDqZkhx0mgDvdtTa/aqiJ2SsT2HbYcnJfyrh04Q+nyc+t7P+4FpUxAUyz9/la3C1+wE/dT78pf7koEiwx34tQScyPNf8hioTHJmtFXk/7Lc50RlOeT9f9KNLXP2nuLDEWS0U6GtExbB3VRSIL3OJyqyBprY/hQNuFBRXZL55LOH2hpJ8uE2UfIDcA==
Received: from CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26) by
 MN2PR08MB6304.namprd08.prod.outlook.com (2603:10b6:208:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 05:32:48 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::f8) by CH2PR05CA0013.outlook.office365.com
 (2603:10b6:610::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 05:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 05:32:47 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 23:32:45 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 22 Oct 2024 23:32:45 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: Davidlohr Bueso <dave@stgolabs.net>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>, Eishan Mirakhur <emirakhur@micron.com>,
	"Ajay Joshi" <ajayjoshi@micron.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl/mbox: support background operation abort requests
Thread-Topic: [PATCH 0/3] cxl/mbox: support background operation abort
 requests
Thread-Index: AQHbJQz8FzA9v+ny3E+tJavYUeybeg==
Date: Wed, 23 Oct 2024 05:32:45 +0000
Message-ID: <feef15c9fcfd462e9b3cf614a1b4621c@micron.com>
References: <20241022031809.242591-1-dave@stgolabs.net>
In-Reply-To: <20241022031809.242591-1-dave@stgolabs.net>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MN2PR08MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d29e633-c1f7-4046-7c3a-08dcf324211c
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?sX3jePxUaaNCOPLQmkwch4G5Cz6GkPnL+J1fJKjYX3Dc2jIoFAhaOLh4df?=
 =?iso-8859-1?Q?rgqFqSVy6ePI0qXotq3QrS3gj+9N2Jnp59sTGzhS1ecZJcUj9/eAPfarDT?=
 =?iso-8859-1?Q?0EhRUvtInsgebuVFW4ZD24vpWJGzF5b+t23UDNeyo59rlzpxLFs5B7p7FV?=
 =?iso-8859-1?Q?wJSBMuUIVQ22o+yR1oNIdFWs+Q0f4Pbj0ecAtzogRAF9wPMTbWIf8dGWhx?=
 =?iso-8859-1?Q?b6gJKckgqLNEWL7ceXqpNGVP5HbsGp8r2f+5lzulH0QYvw9u6K/hM0syRb?=
 =?iso-8859-1?Q?s+EDCcz5EIojgDr2lXgonuZhRi0a0J18jwxiLeFz1UKFwkx933BOcgVNSy?=
 =?iso-8859-1?Q?CQplowyHXy4oyrQDOeYKBwrEWaLPkYBppkmN3wOl8N756/q4rU3GBONiKk?=
 =?iso-8859-1?Q?NsvlEvpvCsELQ+gokOLd6al6P3pgqCRbVwYhrXl0YyJxF1NZPfTKGbzDao?=
 =?iso-8859-1?Q?ZN79jDTgYRiGTmDymcn609ZOUV2yHKCG1SKpevT8ANsxi98sw+lUPffG3K?=
 =?iso-8859-1?Q?Z7ebynCRCv4sn1zF/barJAaKEo3AUBhVZqGIamCDOmQb8HlJ1kK/q98ahE?=
 =?iso-8859-1?Q?ylkLApYN67Bx6oK1RFwQgoUNkxIJzmLdEQXNf6yAPUu4nM3dkx1FHiQGC+?=
 =?iso-8859-1?Q?UUjHz3fpchC1Ffdt9t5PdbrZw8mi45SbDvoWjtjRFMb21xTwsNHnOjqYb0?=
 =?iso-8859-1?Q?qK37MkzkbU71b7g0wlVTITkh1BMhPbg20Aq0iu589olxQCEvigsqHFDEQK?=
 =?iso-8859-1?Q?vronZWfdrSnkKaFfA9Bi1RshKeQadux4CGETjeKJvMraFhdcVVQTh/lrQV?=
 =?iso-8859-1?Q?g+FtV0AFBS/m2HfshF3mSePidnaRf3W5nunDdZeUma4/fm9fYM+3Aj7R6O?=
 =?iso-8859-1?Q?Y4i4hjnNj40Q6aC0Mu6G+9CWDA9q8vTRJLOCBAapex73aGMhjL3Z+6eoNg?=
 =?iso-8859-1?Q?3oppiVw0IdXvxypMJ8k/gLxXnH0/D0qQntMxEBjQ8rrmZnvCb7PnbdFlh0?=
 =?iso-8859-1?Q?HerJfx8R9qamZrSAu3P13ptnDFGykUdjtVg6k+CcYXxuuoIGRowhyDaNCl?=
 =?iso-8859-1?Q?5uGz6Z4Q+AO6wGe93wIUacChJA3R1cNhDbj7gERws0KSv40GVBSeu4UYHQ?=
 =?iso-8859-1?Q?YLK1Mvr+wezt0bUE/I353jezKklhQti6OrwcOWD9rEnJoKD4wxihLiYl+y?=
 =?iso-8859-1?Q?WFfH5RT0iCHl+JjNQs7IM+t200JVADsbCsvJNnarefTKdCe4Ehh13cwKF7?=
 =?iso-8859-1?Q?lBao6H+CNi/tOmuC5xPQlu3Lsm41vmTzOTOyZ3HUNI+70qBNP+5Y+Q6aAH?=
 =?iso-8859-1?Q?zKhlGHQkQzQ5ptvW9GHSe0ghfTG7Eouip2rG3EhgGeC8mw/6X7mDcN/ito?=
 =?iso-8859-1?Q?p1YcaqDHISvFsqrTnhoGGJN0/iE1zaoZ/na1CsmKJ0Krr7w+b0xbV0R7Mr?=
 =?iso-8859-1?Q?H8eDrQ5efC7pvmC95OzKIp4DbBITLAfKNod06w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:32:47.8092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d29e633-c1f7-4046-7c3a-08dcf324211c
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6304

Hi Davidlohr,

   We have recently submitted an RFC to implement Request Background Abort
in case a timeout is encountered while executing a background command.
The patch series disables those background commands which do not support ab=
ort
based on their individual CEL properties.

https://lore.kernel.org/linux-cxl/20241017163215.00000547@Huawei.com/T/#ma6=
710971908b85a5f8c5da2e23b8102b5a6e277c

This implementation is based on Dan's suggestion in a previous thread.
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

We can discuss more on how we can potentially merge and arrive at a common =
ground.

--Ravi.
>On Mon, 21 Oct , Davidlohr Bueso wrote:
>Hello,
>
>This series implements the abortable capabilities for mailbox background
>operations, introduced in CXL 3.1.
>
>Details in each patch, but patch 1 moves non-sanitize background command
>polling out of the mbox_mutex, such that patch 2 can add the machinery
>to request aborting the on going command. Patch 3 simply renames a call.
>
>While an overal policy could include command-priorities (which could
>be trivially added); the current policy is that, if there is an on going
>background operation, a new incoming bg-capable command will blindly
>request it to be cancelled, if capable.
>
>Considering the interest of this for Logs[0], perhaps Micron folks could
>this? Does this work along the lines of what that discussion concluded?
>
>Applies against Linus' latest tree.
>
>[0]: https://lore.kernel.org/all/20240313071218.729-1-sthanneeru.opensrc@m=
icron.com/
>
>Testing:
>
>lockdep enabled kernel + the qemu counterpart patches:
>    https://lore.kernel.org/linux-cxl/20240813221255.179200-1-dave@stgolab=
s.net/=20
>
>#> echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize && sleep 3 && echo=
 1 > /sys/bus/cxl/devices/mem1/security/sanitize
>[  185.928276] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0d:00.0: =
Sending command: 0x4400cxl/devices/mem1/security/sanitize
>[  185.930024] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:=
00.0: Doorbell wait took 0ms
>[  185.931608] cxl_pci:__cxl_pci_mbox_send_cmd:306: cxl_pci 0000:0d:00.0: =
Sanitization operation started
>[  188.936583] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0d:00.0: =
Sending command: 0x0005
>[  188.943956] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:=
00.0: Doorbell wait took 0ms
>[  188.951786] cxl_pci:cxl_try_to_cancel_background:376: cxl_pci 0000:0d:0=
0.0: Sanitization operation aborted
>[  188.957762] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0d:00.0: =
Sending command: 0x4400
>[  188.959886] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:=
00.0: Doorbell wait took 0ms
>[  188.962325] cxl_pci:__cxl_pci_mbox_send_cmd:306: cxl_pci 0000:0d:00.0: =
Sanitization operation started
>[  197.034644] cxl_pci:cxl_mbox_sanitize_work:164: cxl_pci 0000:0d:00.0: S=
anitization operation ended
>
>#> cxl update-firmware -F img.fw mem1 && sleep 3 && echo 1 > /sys/bus/cxl/=
devices/mem1/security/sanitize
>[   14.443484] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: =
Sending command: 0x0200
>[   14.445884] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:=
00.0: Doorbell wait took 0ms
>[   14.448744] cxl_core:cxl_query_cmd:539: cxl_mem mem1: Query IOCTL
>[   14.450458] cxl_core:cxl_query_cmd:539: cxl_mem mem1: Query IOCTL
>[   14.452307] cxl_core:cxl_send_cmd:644: cxl_mem mem1: Send IOCTL
>[   14.453686] cxl_core:handle_mailbox_cmd_from_user:602: cxl_pci 0000:0e:=
00.0: Submitting Get FW Info command for user
>[   14.453686]  opcode: 200
>[   14.453686]  size: 0
>[   14.460453] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: =
Sending command: 0x0201
>[   14.462313] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:=
00.0: Doorbell wait took 0ms
>[   14.464166] cxl_pci:__cxl_pci_mbox_send_cmd:310: cxl_pci 0000:0e:00.0: =
Mailbox background operation (0x0201) started
>[   14.466536] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: =
Sending command: 0x0200
>[   14.468380] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:=
00.0: Doorbell wait took 0ms
>{
>  "memdev":"mem1",
>  "pmem_size":"1024.00 MiB (1073.74 MB)",
>  "serial":"0",
>  "host":"0000:0e:00.0",
>  "firmware":{
>    "num_slots":2,
>    "active_slot":1,
>    "online_activate_capable":true,
>    "slot_1_version":"BWFW VERSION 0",
>    "fw_update_in_progress":true,
>    "remaining_size":"48.83 MiB (51.20 MB)"
>  }
>}
>cxl memdev: cmd_update_fw: firmware update started on 1 mem device
>[   17.484680] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: =
Sending command: 0x0005
>[   17.486993] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:=
00.0: Doorbell wait took 0ms
>[   17.489510] cxl_pci:cxl_pci_mbox_send:451: cxl_pci 0000:0e:00.0: Mailbo=
x background operation (0x0201) aborted
>[   17.492476] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: =
Sending command: 0x4400
>[   17.494937] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:=
00.0: Doorbell wait took 0ms
>[   17.497598] cxl_pci:__cxl_pci_mbox_send_cmd:306: cxl_pci 0000:0e:00.0: =
Sanitization operation started
>[   25.682631] cxl_pci:cxl_mbox_sanitize_work:164: cxl_pci 0000:0e:00.0: S=
anitization operation ended
>
>Thanks!
>
>Davidlohr Bueso (3):
>  cxl/pci: lockless background synchronous polling
>  cxl/mbox: support aborting the current background operation
>  cxl/pci: rename cxl_mbox_background_complete()
>
> drivers/cxl/core/mbox.c |   1 +
> drivers/cxl/cxlmem.h    |  14 +++
> drivers/cxl/pci.c       | 189 ++++++++++++++++++++++++++++------------
> include/cxl/mailbox.h   |   2 +
> 4 files changed, 152 insertions(+), 54 deletions(-)
