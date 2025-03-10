Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9321B4153
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586033; cv=none; b=dXeHTNvbsEEE+joNFgoPQwGMPqPxcwQUHrZOLDtHSMZMFcl6XuYkZaRZh2BhNJEd5a0q7BehpsGNP9M99laPrXqXoxRmW6xjexZ9So1Zhp074fs4cQVtojfFgRJz4gx1bfX3WHXP/gfA7lCDvFTzO5NAnhVQPZdJQ9MDbeFZOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586033; c=relaxed/simple;
	bh=30E5IMpQV/S4fCBFeyBj9vI79x0xSB7Ba3yhoEn/Uao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmKo5zm6+usAG/z+kiIwlBOo1wCvG0wwlODyeh94UawTRGx2kd87ATSYxx1qTX94U2IfK71wMKVbgG/nmmGm6z74wcasYMR4YXVlHy5bK0FNtCToNy/qQsr6GlnDkPmcSJYA1W+rvnxdIIOrDpjTQTBZE7oHgaQSgZOfbgBZreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZtMErK/7; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZtMErK/7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741586032; x=1773122032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=30E5IMpQV/S4fCBFeyBj9vI79x0xSB7Ba3yhoEn/Uao=;
  b=ZtMErK/7ONZxslrn0A1l568/APk3UMmTvojimmQTW0ZYJmbdaQhPKboN
   ykBdU5NOHiK8AmIXjqhBh+LrEbUc0nW4Lkc+jL/RDecf39zfHtTacZAyV
   ANR4lbSR4zW5S2WOqNo7fhwkC+Sm8X5PhwVXVVkTHfj9ForWl/VzgUNgh
   PdiXa3XHjMX4hm0x2bz/ZWGrO3mNQGVQfLUywhAkpsT0M4Yb3XXItHHTn
   V3isTFokyQgidW2+BWwCyrW4cHwh1n2WkBw4dE6QBCpZTeEE9J6VV5EJi
   TfOWG1RKok76JVJF8sbjcFaoZs/pJPQVDY+t4DMdJ0OAgcCBJu8p5Pf9n
   g==;
X-CSE-ConnectionGUID: lMFXQXnjRKKUmfL9KW64Bg==
X-CSE-MsgGUID: cBC2ERSJQeay0cB5MYU1Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="179877479"
X-IronPort-AV: E=Sophos;i="6.14,235,1736780400"; 
   d="scan'208";a="179877479"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 14:52:41 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 29282D6EAA
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 14:52:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DCEACCFBA8
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 14:52:38 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2B72E1A0078;
	Mon, 10 Mar 2025 13:52:37 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>,
	terry.bowman@amd.com
Cc: y-goto@fujitsu.com,
	nafonten@amd.com,
	david@redhat.com,
	nifan.cxl@gmail.com,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org,
	gourry@gourry.net
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED resources
Date: Mon, 10 Mar 2025 13:52:34 +0800
Message-ID: <20250310055234.3704571-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <Z8sjPkLpcmM8G93K@aschofie-mobl2.lan>
References: <Z8sjPkLpcmM8G93K@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>On Fri, Mar 07, 2025 at 05:56:25AM +0000, Zhijian Li (Fujitsu) wrote:=0D
>> Hello Fontenot,=0D
>> =0D
>> I hope this email finds you well.=0D
>> =0D
>> Thank you very much for this patch. We've encountered the same issue in =
our product,=0D
>> and your patch works.=0D
>> =0D
>> We do hope this issue will be resolved in the upstream kernel soon.=0D
>> =0D
>=0D
>snip=0D
>=0D
>> =0D
>> =0D
>> I noticed your earlier discussions about designing a new approach to sol=
ve this problem,=0D
>> which I'm pretty excited about. Do you have any idea when you might post=
 the updated=0D
>> version? We'd love to help out with reviewing and testing..=0D
>> =0D
>> If you run into any roadblocks and need a hand, just let us know. we'd b=
e delighted to help.=0D
>> =0D
>> As far as I know, this issue usually arises on Real CXL machines, but fo=
r ease of testing=0D
>> and validation, we modified QEMU to simulate the intersection of 'Soft R=
eserved' and=0D
>> the CXL region, which would aid in verification.=0D
>=0D
>Hi Zhijian,=0D
>=0D
>Wow - I want that! Can you share that QEMU branch?  With QEMU cmdline too.=
=0D
>=0D
=0D
Hi Terry and Alison=0D
=0D
Well, it's a simple hack within the QEMU and seabios project. Their=0D
modifications are as below:=0D
=0D
Note: the QEMU's modification exposed the CFMWs region instead of the CXL=0D
memory region(that the Real CXL machine did)=0D
=0D
After the guest started, you could see the iomem tree:=0D
=0D
a90000000-1a8fffffff : CXL Window 0=0D
  a90000000-1a8fffffff : Soft Reserved=0D
=0D
=0D
QEMU:=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
diff --git a/hw/i386/pc.c b/hw/i386/pc.c=0D
index f199a8c7ad19..484ad7e5e632 100644=0D
--- a/hw/i386/pc.c=0D
+++ b/hw/i386/pc.c=0D
@@ -963,6 +963,9 @@ void pc_memory_init(PCMachineState *pcms,=0D
                 memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops=
, fw,=0D
                                       "cxl-fixed-memory-region", fw->size)=
;=0D
                 memory_region_add_subregion(system_memory, fw->base, &fw->=
mr);=0D
+#define E820_TYPE_SOFT_RESERVED 0xefffffff=0D
+                /* add special purpose memory */=0D
+                e820_add_entry(fw->mr.addr, fw->mr.size , E820_TYPE_SOFT_R=
ESERVED);=0D
                 cxl_fmw_base +=3D fw->size;=0D
                 cxl_resv_end =3D cxl_fmw_base;=0D
             }=0D
=0D
=0D
seabios=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
diff --git a/src/e820map.c b/src/e820map.c=0D
index c761e5e98a75..9440039541a6 100644=0D
--- a/src/e820map.c=0D
+++ b/src/e820map.c=0D
@@ -54,6 +54,7 @@ e820_type_name(u32 type)=0D
     case E820_ACPI:     return "ACPI";=0D
     case E820_NVS:      return "NVS";=0D
     case E820_UNUSABLE: return "UNUSABLE";=0D
+    case E820_TYPE_SOFT_RESERVED: return "Soft Reserved";=0D
     default:            return "UNKNOWN";=0D
     }=0D
 }=0D
diff --git a/src/e820map.h b/src/e820map.h=0D
index 07ce16ec213f..dd416d5ba3df 100644=0D
--- a/src/e820map.h=0D
+++ b/src/e820map.h=0D
@@ -8,6 +8,7 @@=0D
 #define E820_ACPI         3=0D
 #define E820_NVS          4=0D
 #define E820_UNUSABLE     5=0D
+#define E820_TYPE_SOFT_RESERVED 0xefffffff=0D
 =0D
 struct e820entry {=0D
     u64 start;=0D
diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c=0D
index e5d4eca0cb5a..38a9bfed04df 100644=0D
--- a/src/fw/paravirt.c=0D
+++ b/src/fw/paravirt.c=0D
@@ -781,6 +781,12 @@ static int qemu_early_e820(void)=0D
                 if (RamSizeOver4G < table.address + table.length - 0x10000=
0000LL)=0D
                     RamSizeOver4G =3D table.address + table.length - 0x100=
000000LL;=0D
             }=0D
+            break;=0D
+        case E820_TYPE_SOFT_RESERVED:=0D
+            e820_add(table.address, table.length, table.type);=0D
+            dprintf(1, "qemu/e820: addr 0x%016llx len 0x%016llx [Sort rese=
rved]\n",=0D
+                 table.address, table.length);=0D
+            break;=0D
         }=0D
     }=0D
=0D
=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
QEMU comand line(nothing special to QEMU expect specifying your own bios):=
=0D
=0D
/path/to/qemu <...args...> \=0D
-machine type=3Dq35,cxl=3Don \=0D
-bios /path/to/seabios/out/bios.bin \=0D
-nographic \=0D
-object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D4G \=0D
-device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \=0D
-device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \=
=0D
-device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-vmem0 =
\=0D
-M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D64G=0D
=0D
=0D
