Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BA20AF7D;
	Tue, 18 Mar 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339504; cv=none; b=Ibnom9XTZQKaRL8M5P26Xa/xtVH927+LcQegizqvcnUhvgIQHsUJyUJazox3+9Ph9ym8AXrSzAdd36HBcRfttEqIWbKqp8RuR44fMiLOYKZ+DGz23kH3Rom1+2F4eoI6S9rASiiribCRw80c7YkANlLDJ9XXs4x+panowF6Dlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339504; c=relaxed/simple;
	bh=NJPyrqEcgluQws6lcoyeF0cE/wNb04BfEvkOF+x8rYY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1Ht11Q8y/GxDeE/pc/Nxj41G5mwpUpi2VlVUJ4qkfUJ/NzeF3d/D0lMgZ9KT+IKCPOHbNGzk7t66D2UqLJlLT3kRVyU+iNKqff8sRC4xSx/4IWAQ9dZ08uAdYJdgEA4A6JF47mGLWwqKvw6f5wA/dvfuU10wIJKBwB17xAZRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO5GGhtA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO5GGhtA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225df540edcso2891935ad.0;
        Tue, 18 Mar 2025 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339502; x=1742944302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4D9JDXCW2CkvXSvq16QYN4jLxycxNiAak9I8Hpmw+8o=;
        b=WO5GGhtAEy0ac5MRf82uagikcp8LFAhHtTmmNlhBhz5ZPcY/egfqhsM8Fjs/k3yFi1
         /dl7BzlPymUlDhywJnp68ayG+49hvVrzaBwvtimw5JEpUbgtp2YPahXcf5j3BtDQvZnq
         SOnYtBVHPJkOR4MS/uwS5BRWAzoLRfmvK12cuNG3OZzKihped5nBLVDpXWKwNuEijF1W
         bM2HB5SQw6MiRUWVNa2YXXeoKhZQmsYbxtRwI4yugTfA9Ls3CFkPyJ5EKkO0dwtkyvY6
         Z4qNWaOh7UJOPrSlY20lQGihjwzi//tW58npBAPcmeuNydch7SbD991a4fwX9JIpx1tr
         y3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339502; x=1742944302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D9JDXCW2CkvXSvq16QYN4jLxycxNiAak9I8Hpmw+8o=;
        b=kTUTP4KWPSsaeMEawqv7Qc50uoLDSRf2QPPgi2/8IwJj3QmrOD/BDIzk6tC0UeI5AA
         uG8J38KzclY85/MGUt4XTwVs1T+XmVXzxy03qV9a7It/D+bfwMWXMKu8GLVCypt3wBJ+
         NYKHZZp5AT73Q+dzPuFUEo+TKcmexd82DOJk53StM3YitejSlO6KcapPpEMSMKZbnqqA
         4+F5bauvR/wR1OIyFLPpIedNHH1c5oJTPvDmL7Lo/tlKZ3/qzWq5yfzyi3B8CsnwRXWG
         Sb6I0QParaZcxjilPn/a27lEtTDARqXCW2AJcTqHFGuyHW04KuyfGNWcFQmaA+4UuTm5
         RzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4gXpOpzZDmHmG30+8Kac6Vbj1AeEYGIP2i9gECUgU/BgadcCuBz3nxgima1I4yD0LdLAfK57eY7o=@vger.kernel.org, AJvYcCVGsDB2ClTo9KOAl8DPVwDHzrKbDvrdF0aScQLybJxLxXH2bYqY7gsB4gsoY+h/G37sOftUO850qZV8wrCN@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTJznQP9a4+pXVuLsHXf34m1+NMrZ6I8bBbNoE8fKQ3TvHP4O
	Ju3ON+M4RMj09DUEyH/kCwDCjGf2qQo1tcbM8Mo/IR3bA4AvkSrT
X-Gm-Gg: ASbGncs9FFNz7QrWP0vwGqmstWoLcJIjHy1hV2RzfnE1Q5/6Z1ypx9WwGXea+nHT0Py
	JWre/tJZg98M7690Tf/p/G+F8zMeHHGj3PWHnPvhS5nnPbTqyFVH55ON2sCSU8W3DKt2ImzPhA6
	EgK76cMrPs0vyPNg0S7uwFfsdKcjlQHKf7Soa8JJCVoYamjCmmB2nkDyIzQtsKZPS19rv6Czg0y
	zg/sQmgIJp2uo2ZOteWuwguleFSCfq3g8uUjVoj+HcmFWGho7LXRo11cJromaprRN57dl036z8+
	IwyjZPhtW9fAgvm8t9mN7cNlaQiNdD00szJzqDA=
X-Google-Smtp-Source: AGHT+IG5lXu3PIrdg7QAgovU1iWfJtPWO9/ye813mTFa3BsP9yaoeQt3knz63GLk9bcs8hBdj2F+ow==
X-Received: by 2002:a05:6a00:ac4:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-7376d538435mr842988b3a.3.1742339502105;
        Tue, 18 Mar 2025 16:11:42 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e69sm10527299b3a.141.2025.03.18.16.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:11:41 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 18 Mar 2025 16:11:38 -0700
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, nifan.cxl@gmail.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, linux-kernel@vger.kernel.org,
	anisa.su887@gmail.com
Subject: Re: [RFC] cxl/region: set numa node for target memdevs when a region
 is committed
Message-ID: <Z9n9qpySEkwbXN_F@debian>
References: <20250314164629.6937-1-nifan.cxl@gmail.com>
 <ac564c1e-95e4-46d0-95c7-7f72c8fee0c2@intel.com>
 <67d9e4d43360e_201f0294d6@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d9e4d43360e_201f0294d6@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Mar 18, 2025 at 02:25:40PM -0700, Dan Williams wrote:
> Dave Jiang wrote:
> > 
> > 
> > On 3/14/25 9:40 AM, nifan.cxl@gmail.com wrote:
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > There is a sysfs attribute named "numa_node" for cxl memory device.
> > > however, it is never set so -1 is returned whenever it is read.
> > > 
> > > With this change, the numa_node of each target memdev is set based on the
> > > start address of the hpa_range of the endpoint decoder it associated when a
> > > cxl region is created; and it is reset when the region decoders are
> > > reset.
> > > 
> > > Open qeustion: do we need to set the numa_node when the memdev is
> > > probed instead of waiting until a region is created?
> > 
> > Typically, the numa node for a PCI device should be dev_to_node(),
> > where the device resides. So when the device is probed, it should be
> > set with that. See documentation [1]. Region should have its own NUMA
> > node based on phys_to_target_node() of the starting address.  
> 
> Right, the memdev node is the affinity of device-MMIO to a CPU. The
> HDM-memory that the device decodes may land in multiple proximity
> domains and is subject to CDAT, CXL QoS, HMAT Generic Port, etc...
> 
> If your memdev node is "NUMA_NO_NODE" then that likely means the
> affinity information for the PCI device is missing.
> 
> I would double check that first. See set_dev_node() in device_add().

Thanks Dave and Dan for the explanation. 
Then the issue must be from qemu setup.

I added some debug code as below
---------------------------------------------
fan:~/cxl/linux-fixes$ git diff
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f05198114..c86a9eb58e99 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3594,6 +3594,10 @@ int device_add(struct device *dev)
        if (kobj)
                dev->kobj.parent = kobj;
 
+        dev_dbg(dev, "device: '%s': %s XX node %d\n", dev_name(dev), __func__, dev_to_node(dev));
+        if (parent) {
+                dev_dbg(parent, "parent device: '%s': %s XX node %d\n", dev_name(parent), __func__, dev_to_node(parent));
+        }
        /* use parent numa_node */
        if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
                set_dev_node(dev, dev_to_node(parent));
---------------------------------------------

The output after loading cxl related drivers looks like below. All
numa_node is -1 in the cxl topology. 

Hi Jonathan,
   do I miss something in the qemu setup ??

qemu-system-x86_64 -s  -kernel bzImage -append "root=/dev/sda rw console=ttyS0,115200 ignore_loglevel nokaslr \
cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl_core.dyndbg=+fplm cxl_mem.dyndbg=+fplm cxl_pmem.dyndbg=+fplm \
cxl_port.dyndbg=+fplm cxl_region.dyndbg=+fplm cxl_test.dyndbg=+fplm cxl_mock.dyndbg=+fplm \
cxl_mock_mem.dyndbg=+fplm dax.dyndbg=+fplm dax_cxl.dyndbg=+fplm device_dax.dyndbg=+fplm" \
-smp 8 -accel kvm -serial mon:stdio  -nographic  -qmp tcp:localhost:4445,server,wait=off \
-netdev user,id=network0,hostfwd=tcp::2024-:22 -device e1000,netdev=network0  -monitor telnet:127.0.0.1:12346,server,nowait \
-drive file=/home/fan/cxl/images/qemu-image.img,index=0,media=disk,format=raw -machine q35,cxl=on -cpu qemu64,mce=on \
-m 8G,maxmem=64G,slots=8  -virtfs local,path=/opt/lib/modules,mount_tag=modshare,security_model=mapped  \
-virtfs local,path=/home/fan,mount_tag=homeshare,security_model=mapped -object \
memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/host//cxltest.raw,size=512M  \ 
-object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/host//lsa.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true  \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2   \
-device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0xabcd    \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k

---------------------------------------------
fan:~/cxl/linux-fixes$ cat .config | grep CONFIG_NUMA
# CONFIG_NUMA_BALANCING is not set
CONFIG_NUMA=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_NUMA_MEMBLKS=y
# CONFIG_NUMA_EMU is not set
fan:~/cxl/linux-fixes$ 

---------------------------------------------
root@debian:~# echo 'file core.c +p' >> /sys/kernel/debug/dynamic_debug/control
root@debian:~# dmesg | grep XX
root@debian:~# dmesg | grep XX
[   44.939510] wakeup wakeup14: device: 'wakeup14': device_add XX node -1
[   44.940195] acpi ACPI0017:00: parent device: 'ACPI0017:00': device_add XX node -1
[   44.941402] cxl root0: device: 'root0': device_add XX node -1
[   44.942023] cxl_acpi ACPI0017:00: parent device: 'ACPI0017:00': device_add XX node -1
[   44.947546] cxl decoder0.0: device: 'decoder0.0': device_add XX node -1
[   44.948219] cxl root0: parent device: 'root0': device_add XX node -1
[   44.958637] cxl port1: device: 'port1': device_add XX node -1
[   44.959245] cxl root0: parent device: 'root0': device_add XX node -1
[   44.990326] cxl decoder1.0: device: 'decoder1.0': device_add XX node -1
[   44.991014] cxl_port port1: parent device: 'port1': device_add XX node -1
[   44.993947] cxl decoder1.1: device: 'decoder1.1': device_add XX node -1
[   44.994593] cxl_port port1: parent device: 'port1': device_add XX node -1
[   44.997521] cxl decoder1.2: device: 'decoder1.2': device_add XX node -1
[   44.998203] cxl_port port1: parent device: 'port1': device_add XX node -1
[   45.001142] cxl decoder1.3: device: 'decoder1.3': device_add XX node -1
[   45.001821] cxl_port port1: parent device: 'port1': device_add XX node -1
[   45.005465] cxl nvdimm-bridge0: device: 'nvdimm-bridge0': device_add XX node -1
[   45.006206] cxl root0: parent device: 'root0': device_add XX node -1
[   45.072975] cxl mem0: device: 'mem0': device_add XX node -1
[   45.073519] cxl_pci 0000:0d:00.0: parent device: '0000:0d:00.0': device_add XX node -1
[   45.074937] firmware mem0: device: 'mem0': device_add XX node -1
[   45.075525] cxl mem0: parent device: 'mem0': device_add XX node -1
[   45.095409] nd ndbus0: device: 'ndbus0': device_add XX node -1
[   45.096135] cxl_nvdimm_bridge nvdimm-bridge0: parent device: 'nvdimm-bridge0': device_add XX node -1
[   45.097476] nd ndctl0: device: 'ndctl0': device_add XX node -1
[   45.099208] nd_bus ndbus0: parent device: 'ndbus0': device_add XX node -1
[   45.101286] cxl pmem0: device: 'pmem0': device_add XX node -1
[   45.102633] cxl_mem mem0: parent device: 'mem0': device_add XX node -1
[   45.108757] nd nmem0: device: 'nmem0': device_add XX node -1
[   45.109317] nd_bus ndbus0: parent device: 'ndbus0': device_add XX node -1
[   45.119846] cxl endpoint2: device: 'endpoint2': device_add XX node -1
[   45.120474] cxl_port port1: parent device: 'port1': device_add XX node -1
[   45.149351] cxl decoder2.0: device: 'decoder2.0': device_add XX node -1
[   45.150029] cxl_port endpoint2: parent device: 'endpoint2': device_add XX node -1
[   45.153057] cxl decoder2.1: device: 'decoder2.1': device_add XX node -1
[   45.153700] cxl_port endpoint2: parent device: 'endpoint2': device_add XX node -1
[   45.156723] cxl decoder2.2: device: 'decoder2.2': device_add XX node -1
[   45.157384] cxl_port endpoint2: parent device: 'endpoint2': device_add XX node -1
[   45.160407] cxl decoder2.3: device: 'decoder2.3': device_add XX node -1
[   45.161073] cxl_port endpoint2: parent device: 'endpoint2': device_add XX node -1
root@debian:~# 


