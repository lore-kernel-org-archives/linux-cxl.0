Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070EE288A8
	for <linux-cxl@vger.kernel.org>; Sat, 26 Jul 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753549296; cv=none; b=eT5PIaZTdpQsQQ7c6YzyoYE0YulbsZTrHX1/bWrvOdNpN+ZnVlA8N5wWLlKtBkb0TJkX8b7541pzZgP29pxwC+TK+sdDnLRy+6f7uqhsMdySuqQXGgTCcqktLu6Xnb4mWw5oWXUirAVSG3ZgU2WGCFdSWMVRvxbJ8XlXHaJ0c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753549296; c=relaxed/simple;
	bh=48RBok0bWM6qIGkr4CCzpNOIbfJe9lQO9BlDLlCIc1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5kEAoJmXtr4V0q4rrRMcG7FqpP3b0nd+Z+RFx3ADJC+OQW1ov2jKR3xJXFqicRwEKMPJ77PeTG6qY9Fzak2p3hW3zL7ErBJoIzbTZXI1V9r0G6KDyjLw00YtVG/T//d8C+s6D6HOfynpXhwW/mgd+RMCbkq8h/zo+ZRUGbfwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L///39rU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L///39rU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2350b1b9129so21809945ad.0
        for <linux-cxl@vger.kernel.org>; Sat, 26 Jul 2025 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753549294; x=1754154094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8o/hDLEr8mUgOt0ZGZLmOGoGk0JwTQovCF4wYoVGLuk=;
        b=L///39rUfknJzSX4SIO+m9PDNRJzaCfoQu1bmUMweubpWwJPoltcw+H9LyHDKFlJI0
         pznmKZM8ob1TvZl3nKEmz6GE9yMoxbjIjRIpIXYkZBzE8+p4AQtSd7s4evADFM+8pj1J
         0tAljPeDBASydBIZdOF/HN/ledAjBhtVBz5I6NSC+ilMmri4sxI3Qq5qy40GXDnJXuet
         thZNBpMNRK2rhCGMosLo3lTG7+PEDXANwYd8R5eoMMXETkjrj2fIu3WctS9Y6OZ3Anxc
         bAg8EDY1HsuE8yEQsjF+UVU2Pyw8P5msF9qUHf+SbpkHeeIbE41GU5D0b27Am27bi5dn
         aFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753549294; x=1754154094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8o/hDLEr8mUgOt0ZGZLmOGoGk0JwTQovCF4wYoVGLuk=;
        b=rqTObGuuR8gJCRsHpiaYLwD6EDdospDNyaiLqyNcHIeMGmK0RRVTI3D1yAfv1RR72w
         yXUi28jnP1C8n5kLcd9hyoziJM4Yah41//FhNJnzo226YfqhMkNKAUuPOMWP69l4g+f2
         BZKH5VJGdM/TzfJvV8JVkz5M07ZWU745+3gweiq6gUe4LIZnviYhFZlcNMBoYpQEXuDN
         2jIuzfLFHmzIjguBuFS4XxymdzPwo1HOt1Q5tiLANOiqOroFyrB2l+3ZdDhHa3zQm1PO
         rAUuBMRXHOB+aT+IGp6fx3VRCl5VfOD+U+21F7ssHKLxvav1b54dHgIod8bLfnnZgh0M
         y9TA==
X-Forwarded-Encrypted: i=1; AJvYcCXvz7r8Ycd1oXtwaJt5F/L7drEBVwog6p/4/VhOf3FLWuPJe/EvQNRK/rEHKpHA9WUb49zOAambC48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSA6LBywjZfBrz6JZfwoLevYg3jttM490u/EUitZeQIKmy4TA
	14tRlSgTtbg0rq5yxy+rQNdcVIFMPcxEIeTqxfp6DFclJeW7bm5mPxPw
X-Gm-Gg: ASbGncuzRJEsYtYuIbz4MwdcvhQm0ptRMXqOipc1WjW852sB1idUySQkjHXAwTPTQ8q
	zSdhVxW8zpwhWw74KBweGb09bPb8d2xS5FFUsCbVY2/+qJsdRMOZaWKn1GDKm/W0JGHe8f/MwW7
	wzGkHMvPBwabA53zIyfDjGC4oozkypSCmdKFQwdIV/VkjqaBatMU6//UrVG7gXeTzjBiQcWIVKH
	h/dAJpTe1pIS0mrUbWr0+LUSdTfjdYi7SGzhh6plU7hMdWGqnSn8xvvMQXdO7dMkm0zdGj1fAvg
	3GQalfBMp1E3DLXFAY6VhzslkhpjCQZ2mQ8DzD3Xmo/ieMa20hKbO4+wC8oKsZ6sIbQcqoRTOoC
	B3cKecr65hAAnfpztev3aLNJOmmKhEQfgeFQ=
X-Google-Smtp-Source: AGHT+IGlegXpjgdJaL8nFWyXsI1WkXCMWteF5yj3D6ktWNdpCVJh1NBnt5d2ExeSsXkFB0x1yljJjQ==
X-Received: by 2002:a17:903:22c9:b0:236:9726:7261 with SMTP id d9443c01a7336-23fb30dfd0cmr84719225ad.39.1753549294103;
        Sat, 26 Jul 2025 10:01:34 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:6456:3d83:7c59:6543])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe329898sm20326575ad.46.2025.07.26.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 10:01:33 -0700 (PDT)
Date: Sat, 26 Jul 2025 10:01:30 -0700
From: Fan Ni <nifan.cxl@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: peng guo <engguopeng@buaa.edu.cn>, mst@redhat.com,
	marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
	richard.henderson@linaro.org, eduardo@habkost.net,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <aIUJ6jyd3oCXbzQi@lg>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
 <20250725145337.00003c91@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725145337.00003c91@huawei.com>

On Fri, Jul 25, 2025 at 02:53:37PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Jul 2025 21:35:45 +0800
> peng guo <engguopeng@buaa.edu.cn> wrote:
> 
> > When using a CXL Type 3 device together with a virtio 9p device in QEMU, the
> > 9p device fails to initialize properly. The kernel reports the following:
> > 
> >     virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
> >     9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22
> > 
> > Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
> > device was overlapped by the memory window allocated for the CXL devices. As a
> > result, the kernel could not correctly access the BAR region, causing the
> > virtio device to malfunction.
> > 
> > An excerpt from /proc/iomem shows:
> > 
> >     480010000-cffffffff : CXL Window 0
> >       480010000-4bfffffff : PCI Bus 0000:00
> >       4c0000000-4c01fffff : PCI Bus 0000:0c
> >         4c0000000-4c01fffff : PCI Bus 0000:0d
> >       4c0200000-cffffffff : PCI Bus 0000:00
> >         4c0200000-4c0203fff : 0000:00:03.0
> >           4c0200000-4c0203fff : virtio-pci-modern
> > 
> > To address this issue, this patch uses the value of `cxl_resv_end` to reserve
> > sufficient address space and ensure that CXL memory windows are allocated
> > beyond all PCI 64-bit BARs. This prevents overlap with 64-bit BARs regions such 
> > as those used by virtio or other pcie devices, resolving the conflict.
> > 
> > QEMU Build Configuration:
> > 
> >     ./configure --prefix=/home/work/qemu_master/build/ \
> >                 --target-list=x86_64-softmmu \
> >                 --enable-kvm \
> >                 --enable-virtfs
> > 
> > QEMU Boot Command:
> > 
> >     sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
> >         -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
> >         -hda /home/work/gp_qemu/rootfs.img \
> >         -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
> >         -kernel /home/work/linux_output/arch/x86/boot/bzImage \
> >         --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
> >         -object memory-backend-ram,id=vmem0,share=on,size=4096M \
> >         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >         -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> >         -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
> >         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> > 
> > Tested in a QEMU setup with a CXL Type 3 device and a 9pnet virtio device.
> > 
> > Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> Analysis looks good.
> 
> For the patch I wonder if we should match the check that follows
> for pcms->cxl_devices_state.is_enabled rather than checking cxl_resv_end
> (which is only set to non 0 if that is_enabled is set).
> 
> Probably better to use a consistent condition for checking if CXL is
> there or not.
> 
> We also ideally need a suitable fixes tag.  I couldn't immediately find one
> so maybe it goes a long way back.

FYI. Commit histroy related to the line changed,


commit 78732a765986d5270d6b3d88afeb9e4d33092360
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jun 23 14:45:49 2023 +0200

    hw/i386/pc: Use machine_memory_devices_init()

    Let's use our new helper and stop always allocating ms->device_memory.
    Once allcoated, we're sure that the size > 0 and that the base was
    initialized.

    Adjust the code in pc_memory_init() to check for machine->device_memory
    instead of pcmc->has_reserved_memory and machine->device_memory->base.

    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Cc: Richard Henderson <richard.henderson@linaro.org>
    Cc: Eduardo Habkost <eduardo@habkost.net>
    Cc: "Michael S. Tsirkin" <mst@redhat.com>
    Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
    Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
    Acked-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20230623124553.400585-7-david@redhat.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1123,1 +1116,1 @@
-    if (pcmc->has_reserved_memory && machine->device_memory->base) {
+    if (machine->device_memory) {

commit b0c14ec4efe912ae6f14a4802574f7b6b6db0648
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Apr 23 18:51:17 2018 +0200

    machine: make MemoryHotplugState accessible via the machine

    Let's allow to query the MemoryHotplugState directly from the machine.
    If the pointer is NULL, the machine does not support memory devices. If
    the pointer is !NULL, the machine supports memory devices and the
    data structure contains information about the applicable physical
    guest address space region.

    This allows us to generically detect if a certain machine has support
    for memory devices, and to generically manage it (find free address
    range, plug/unplug a memory region).

    We will rename "MemoryHotplugState" to something more meaningful
    ("DeviceMemory") after we completed factoring out the pc-dimm code into
    MemoryDevice code.

    Signed-off-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20180423165126.15441-3-david@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    [ehabkost: rebased series, solved conflicts at spapr.c]
    [ehabkost: squashed fix to use g_malloc0()]
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1432,1 +1435,1 @@
-    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
+    if (pcmc->has_reserved_memory && machine->device_memory->base) {

commit bb292f5a9b944e47fae88a20767967e7e20122b4
Author: Eduardo Habkost <ehabkost@redhat.com>
Date:   Fri Dec 11 16:42:28 2015 -0200

    pc: Remove compat fields from PcGuestInfo

    Remove the fields: legacy_acpi_table_size, has_acpi_build,
    has_reserved_memory, and rsdp_in_ram from PcGuestInfo, and let
    the existing code use the PCMachineClass fields directly.

    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1385,1 +1385,1 @@
-    if (guest_info->has_reserved_memory && pcms->hotplug_memory.base) {
+    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {

commit a7d69ff10b085ba6f8236600829532984cdea714
Author: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date:   Mon Jun 29 13:50:22 2015 +0530

    pc,pc-dimm: Extract hotplug related fields in PCMachineState to a structure

    Move hotplug_memory_base and hotplug_memory fields of PCMachineState
    into a separate structure so that the same can be made use of from
    other architectures supporing memory hotplug.

    Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
    Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
    Tested-by: Igor Mammedov <imammedo@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1336,1 +1336,1 @@
-    if (guest_info->has_reserved_memory && pcms->hotplug_memory_base) {
+    if (guest_info->has_reserved_memory && pcms->hotplug_memory.base) {

commit de268e134c03612970d6f2c214df6287c9621cc8
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Mon Jun 2 15:25:10 2014 +0200

    pc: add 'etc/reserved-memory-end' fw_cfg interface for SeaBIOS

    'etc/reserved-memory-end' will allow QEMU to tell BIOS where PCI
    BARs mapping could safely start in high memory.

    Allowing BIOS to start mapping 64-bit PCI BARs at address where it
    wouldn't conflict with other mappings QEMU might place before it.

    That permits QEMU to reserve extra address space before
    64-bit PCI hole for memory hotplug.

    Signed-off-by: Igor Mammedov <imammedo@redhat.com>
    Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1269,0 +1270,1 @@
+    if (guest_info->has_reserved_memory && pcms->hotplug_memory_base) {


Fan

> 
> > ---
> >  hw/i386/pc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2f58e73d3347..180bc615f3f0 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -975,7 +975,7 @@ void pc_memory_init(PCMachineState *pcms,
> >  
> >      rom_set_fw(fw_cfg);
> >  
> > -    if (machine->device_memory) {
> > +    if (machine->device_memory || cxl_resv_end) {
> >          uint64_t *val = g_malloc(sizeof(*val));
> >          uint64_t res_mem_end;
> >  
> 

-- 
Fan Ni
