Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9E35973
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086707; cv=none; b=ektJMLNmIU9CIDlUyB8PKr1e9Ieh/pCIeu1EhDGTa3HIA2oC1/dxkVAfYvQNJ/tnYyc94CGZVehhPdRC1upZvdiiDOkpwckkHdZV75UO2VM0+PXJ04YNH70ntALG2YJk1wfWKdt46ERPVaQ7EAJ+AOcT0CUK9BJuboOawWLQEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086707; c=relaxed/simple;
	bh=JY5nyCFQj1vBKa6AgVpepKFh4NO3/9dhWtmE0HxXfsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUIyRzA+7CL/tO0ukcfcGxKvcxh9P1NIVLUgAlCuLHZhsiQfB+j1qNCWeMnDOUHIaa7ivuvSKGIDTOhYc/qyuUH+NdNGh3sgLXBzIALd/6t7labulsfLWnMy2rXTm7uEsk2gUouKgmQF9t+eh2n8nsAClrr8/RmjXV6hfm4ri5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwcoyFeG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwcoyFeG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so48323815ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744086705; x=1744691505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZxXm0QlquWnAAgfSfApIkjwAwaOBmaCNIExwOgtGj8=;
        b=IwcoyFeGsBHFFnNLCyO5uioxbtSB1/YxxHI9iS4O+4PeKnuzoYCh80IRqcDKYNr9Oj
         HasdOEGawVxDNqwRGf+c3CNacfLUP9t788q0UhdglwygwDM+85IyEPPljbtcdCsIILoO
         kcWAVIxOvkFR/guPWHX9snhedmisjOcRwK2rzyxTsqOS9so7O4z+1sgh31w0g699IJbX
         y2EhJHMyHx3wzEupE0eHIajP4SaKcQb7tvVS8g90Vu99DQQvlBdmw78VhuzZPszOlaNl
         ttEoAshWdr2kFK8sXfgXo4hJRh3qb1gcBIsPkqxotsnyWqNAu2w98PmNSU4AkyYC93YG
         43QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744086705; x=1744691505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZxXm0QlquWnAAgfSfApIkjwAwaOBmaCNIExwOgtGj8=;
        b=hH3TH2zsdzlvLESqzMHqt9FwkSsc4DCtFnMsn+6oKG0ZQ6ocfli49iHP6LYYb9deCR
         rstKeFKrSj+Qy2G4C57C+fJDJfn2Dq4bhVLOwYK1BH9hbH1yWMAK0LswnspkNXsO0VGn
         rO7Rw63PI3qvMMHaAjo2Qd0YQY+tGzG+t1QFMVEPA6bSgL51JztgNi+GBFucUDir61et
         D7IvU9HttIxHf4AiMPPDfhTmTJdNhlsaba+S3w+eo5TcpM8kHWFRZfB6tNmNZgs9Sh0W
         LJ75biZLIprjDXpKXicH05kQJdK4nrKTFGA2Ib+mwbBug/LnuDANgw1CakoTxxyPU78D
         o2Gw==
X-Gm-Message-State: AOJu0YzeILqo5U4p+G+40C/o/PbIGTDfP4GHCOiONEZ61x4Yr9MYP3r3
	zLieT77Iu4SV3OPGAO/NIAl1gCdNF2NkTyR2qy5hNo4n7gTF3F35
X-Gm-Gg: ASbGncvEz6fUUovUIssASwwEPDgJFQrQicBuraG2m6G+HGLuER2B/NFzyZWwP4IM8VC
	hEl6s+WVaLceFACuIxLoRwb6/Wz74DF6buvaTsBSdG7ZZIWFxPx7w0CoWSAEdQScpVgtj2mgY9R
	IwYpFwCNTZVXoaUXGujNcNhqHTu0CrIc0pYqEzHTUsVWQfR33Vd4fGY4qzXFEYTYo8f4XC4VnKc
	tjudrDYBtEs7mHSMxKCNx4Zm0AEMYzoVDrdSF4pTw10pFIIcKY3SIJIN8ELljwg4kqKADmMNk5L
	YhK0K9LAhiVcJkJcBPdJqzd9r+37OZbdENq7GXjDYzu5qwhSumruJlYlnyKdiA==
X-Google-Smtp-Source: AGHT+IFt6JXfyKu4EDJ++NOKplq8oWv97jONa67euAsJVjmGafxLTnJy8vMDTU8T40tTduhlBACCag==
X-Received: by 2002:a17:902:ce02:b0:224:160d:3f54 with SMTP id d9443c01a7336-22a8a87949cmr203740445ad.31.1744086705155;
        Mon, 07 Apr 2025 21:31:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:31:44 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	anisa.su887@gmail.com,
	gourry@gourry.net,
	Fan Ni <fan.ni@samsung.com>
Subject: [RFC 0/3] Qemu FM emulation
Date: Mon,  7 Apr 2025 21:20:27 -0700
Message-ID: <20250408043051.430340-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

The RFC provides a way for FM emulation in Qemu. The goal is to provide
a context where we can have more FM emulation discussions and share solutions
for a reasonable FM implementation in Qemu.

The basic idea is,

We have two VMs, one is the VM we want to test (named Target VM) and one is the
FM VM. The target VM has the kernel which we are interested (for example, DCD
or RAS feature enabled). The FM VM can be VM with any kernel version as long as
OOB communication support is enabled.

An application running in the FM VM issues FM commands to the underlying device
with OOB channel (e.g., MCTP over I2C), when the device receives the message,
it will not response to the request locally, instead the request will be stored
in a share buffer (implemented with /dev/shm), and a QMP request will be sent
to the target VM to notify there is a MCTP message in the shared buffer,
which needs to be processed. The FM will wait the completion of the request.
The target VM will read the buffer and process the message.
When the process completes, the output payload and any information needs to
return is stored in buffer, and a state field will be reset to notify the FM of
the completion of the processing.

The nice points of the method:
1. It is simple model (consumer-produce model with shm as shared buffer).
2. The communication between the two VMs through the qmp interface is simple.
One qmp interface works for all MCTP messages. Moreover, the qmp interface may
be able to use as a way for the communication between two VMs in different
context.

How we run the test?
Step 1: Start the VM we want to Target VM.
The device interested having "allow-fm-attach=on,mctp-buf-init=on"
For example, for my test, it is the DCD device.

In our test, the kernel run on the target VM is Ira's DCD branch:
https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.

qemu-system-x86_64 -gdb tcp::1235  -kernel bzImage -append "root=/dev/sda rw console=ttyS0,115200 ignore_loglevel nokaslr" \
-smp 8 -accel kvm -serial mon:stdio  -nographic  -qmp tcp:localhost:4445,server,wait=off \
-netdev user,id=network0,hostfwd=tcp::2024-:22    \
-device e1000,netdev=network0  -monitor telnet:127.0.0.1:12346,server,nowait \
-drive file=/home/fan/cxl/images/qemu-image.img,index=0,media=disk,format=raw \
-machine q35,cxl=on -cpu qemu64,mce=on -m 8G,maxmem=64G,slots=8 \
-virtfs local,path=/opt/lib/modules,mount_tag=modshare,security_model=mapped  \
-virtfs local,path=/home/fan,mount_tag=homeshare,security_model=mapped \
-object memory-backend-file,id=cxl-mem2,mem-path=/tmp/host0/t3_cxl2.raw,size=4G \
-object memory-backend-file,id=cxl-lsa2,mem-path=/tmp/host0/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
-device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
-device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
-device cxl-type3,bus=swport2,volatile-dc-memdev=cxl-mem2,id=cxl-dcd0,lsa=cxl-lsa2,num-dc-regions=2,sn=99,allow-fm-attach=on,mctp-buf-init=on \
-machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-dcd0 \
-device virtio-rng-pci,bus=swport1

Step 2: Start the FM VM and run the test program to send MCTP requests and
forward to the target VM for processing.

Note: the kernel for FM VM should have MCTP support.

In the test, we use linux-v6.6-rc6 with Jonathan's MCTP hack patches:
https://github.com/moking/cxl-test-tool/blob/main/test-workflows/mctp/mctp-patches-kernel.patch

qemu-system-x86_64 -gdb tcp::1236 -kernel fm-bzImage -append "root=/dev/sda rw console=ttyS0,115200 ignore_loglevel nokaslr " \
-smp 8 -accel kvm -serial mon:stdio  -nographic  -qmp tcp:localhost:4446,server,wait=off \
-netdev user,id=network0,hostfwd=tcp::2025-:22    \
-device e1000,netdev=network0  -monitor telnet:127.0.0.1:12347,server,nowait \
-drive file=/home/fan/cxl/images/qemu-image-fm.img,index=0,media=disk,format=raw \
-machine q35,cxl=on -cpu qemu64,mce=on -m 8G,maxmem=64G,slots=8  \
-virtfs local,path=/opt/lib/modules,mount_tag=modshare,security_model=mapped  \
-virtfs local,path=/home/fan,mount_tag=homeshare,security_model=mapped \
-object memory-backend-file,id=cxl-mem2,mem-path=/tmp/host1/t3_cxl2.raw,size=4G \
-object memory-backend-file,id=cxl-lsa2,mem-path=/tmp/host1/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
-device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
-device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
-device cxl-type3,bus=swport2,volatile-dc-memdev=cxl-mem2,id=cxl-dcd0,lsa=cxl-lsa2,num-dc-regions=2,sn=99,allow-fm-attach=on \
-machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-dcd0,qmp=127.0.0.1:4445,mctp-msg-forward=on \
-device virtio-rng-pci,bus=swport1

Currently, the code is not clean at all, it is a POC to prove the idea. Only
type3 (including DCD) devices can accept requests from the FM, which should be
easy to extend to support switch-targeted FM command processing.

The code is based on Jonathan's cxl-2025-03-20 branch.
A qemu branch with the code: https://github.com/moking/qemu-jic-clone/tree/fm-qmp

FYI.
I have a tool to make the test easier.
https://github.com/moking/cxl-test-tool/tree/main

Part of .var.config, see run_vars.example

QEMU_ROOT=~/cxl/jic/qemu
# for FM VM
FM_KERNEL_ROOT=~/cxl/linux-v6.6-rc6/
FM_QEMU_IMG=~/cxl/images/qemu-image-fm.img

# for Target VM
KERNEL_ROOT=~/cxl/linux-dcd/
QEMU_IMG=~/cxl/images/qemu-image.img

command:
1. cxl-tool.py --run -T FM_TARGET
2. cxl-tool.py --attach-VM -T FM_CLIENT
3. cxl-tool.py --install-libcxlmi-fm
4. cxl-tool.py --setup-mctp-fm
5. cxl-tool.py --login-fm (run the test program with libcxlmi)

Fan Ni (3):
  cxl_type3: Preparing information sharing between VMs
  cxl_type3: Add qmp_cxl_process_mctp_message qmp interface
  cxl/i2c_mctp_cxl: Add support to process MCTP command remotely

 hw/cxl/cxl-mctp-qmp.c             |  85 +++++++++++++++
 hw/cxl/i2c_mctp_cxl.c             |  68 ++++++++++--
 hw/cxl/meson.build                |   2 +-
 hw/mem/cxl_type3.c                | 166 +++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c          |   5 +
 include/hw/cxl/cxl_device.h       |   8 ++
 include/hw/cxl/cxl_mctp_message.h |  43 ++++++++
 qapi/cxl.json                     |  18 ++++
 8 files changed, 387 insertions(+), 8 deletions(-)
 create mode 100644 hw/cxl/cxl-mctp-qmp.c
 create mode 100644 include/hw/cxl/cxl_mctp_message.h

-- 
2.47.2

